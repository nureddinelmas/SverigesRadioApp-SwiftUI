//
//  ContentView3.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-17.
//

import SwiftUI

struct TumListe: Decodable {
    var copyright : String
    var channels: [Kanallar]

}


struct Kanallar : Decodable, Identifiable {
    var image : String?
    var imagetemplate : String?
    var color : String?
    var tagline : String?
    var siteurl : String?
    var liveaudio : LiveAudio
    var scheduleurl: String?
    var channeltype : String?
    var xmltvid : String?
    var id : Int?
    var name : String?
}


class ContentViewModel: ObservableObject {
    @Published var isFetching = false
    @Published var kanallarim = [Kanallar]()
    @State var errorMessage = ""
    
    init() {
//        fetch data will occur here
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.isFetching = true
//        }
    }
    
    @MainActor
    func fetchData() async {
        let urlString = "https://api.sr.se/api/v2/channels?format=json&pagination=false"
        guard let url =  URL(string: urlString) else { return }
        
        do {
            isFetching = true
        let (data, response) = try await URLSession.shared.data(from: url)
            print(data)
            
            if let resp = response as? HTTPURLResponse, resp.statusCode >= 300 {
                self.errorMessage = "Failed to hit endpoint with bad status code"
            }
            DispatchQueue.main.async {
                if let tumListe = try? JSONDecoder().decode(TumListe.self, from: data){
                    self.kanallarim = tumListe.channels
                    self.isFetching = false
                }
            }
           
            
               
        
        } catch{
            isFetching = false
            print("Failed to reach endpoing : \(error)")
        }
}
}


struct ContentView3: View {
    @ObservedObject var vm = ContentViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                if vm.isFetching {
                    Text("is fetching data from internet")
                }
                
                VStack{
                    ForEach(vm.kanallarim) {kanal in
                        let url = URL(string: kanal.imagetemplate ?? "")
                        AsyncImage(url: url){image in
                            image.resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        Text(kanal.name ?? "")
                        
                    }
                }
             
               
            }
            .navigationTitle("Channels")
            .task {
                await vm.fetchData()
            }
            .navigationBarItems(trailing: refreshButton)
        }
    }
    
    
    private var refreshButton: some View {
        Button {
//            async {
            Task.init {
                withAnimation {
                    vm.kanallarim.removeAll()
                }
                await vm.fetchData()
            }
           
        } label: {
            Text("Refresh")
        }

    }
}

struct ContentView3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView3()
    }
}

