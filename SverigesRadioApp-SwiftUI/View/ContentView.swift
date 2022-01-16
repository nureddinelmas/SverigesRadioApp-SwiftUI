//
//  ContentView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-12.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @State var channels:Channels?
    @ObservedObject var apiModel = ApiModel()
//    @State var apiModelWeather = ApiWeather()
    @ObservedObject var apiProgram = ProgramsApi()
    @State private var showingSheet = false
    var body: some View {
        NavigationView{
            VStack{
                ScrollView(.horizontal){
                    HStack{
                        ForEach(apiModel.channels){item in
                            
                                NavigationLink {
                                    ChannelsView(myChannel: item)
                                } label: {
                                    VStack{
                                        ImageView(imageString: item.imagetemplate)
                                        Text(item.name).font(.system(size: 20, weight: .bold, design: .default))
                                        Text(item.channeltype).font(.system(size: 15, weight: .bold, design: .default))
                                        
                                }
                                }
                        }
                    }
                    .navigationTitle("Channels")
                    
                    }
                
                
                
                SwiftUI.List{

                    ForEach(apiProgram.programs){item in
                              
                        
                            NavigationLink {
                                ProgramsView(programs: item)
                            } label: {
                                VStack(alignment: .center){
                                WebImage(url: URL(string: item.programimagetemplate)).resizable().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.3, alignment: .center)
                                            Text(item.name).font(.system(size: 20, weight: .bold, design: .default))
                                            Text(item.description).font(.system(size: 15, weight: .bold, design: .default))
                                            
                                    }
                                
                            }
                            
                            }
                    .navigationTitle("Programs")
                    }
            }
            .toolbar(){
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "person.circle")
                        Text("Sign In")
                    }.sheet(isPresented: $showingSheet) {
                        InloggningView()
                    }
               
 
                }
                
            }


        }
      }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
