//
//  MyPageView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-19.
//

import SwiftUI
import Firebase

struct MyPageView: View {
    @ObservedObject var chanApiModel = ChannelApiModel()
    @ObservedObject var progApiModel = ProgramsApi()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        TabView{
            ProgramsRowInMyPage().tabItem {
                HStack{
                    Image(systemName: "star.bubble")
                    Text("Favori Programs")
                }
              
            }
           
            ChannelRowInMyPage(chanApiModel: chanApiModel).tabItem {
                HStack{
                    Image(systemName: "radio.fill")
                    Text("Favori Channels")
                }
               
            }
            
        }
        
        
        
        .navigationTitle("My Page")
        .navigationBarItems(trailing: logoutButton )
}
    
    var logoutButton: some View {
        Button {
                FirebaseActions.sharedUser.signout()
                presentationMode.wrappedValue.dismiss()
                chanApiModel.channelsSavedArray.removeAll()
                progApiModel.favoriInfoArray.removeAll()

        } label: {
            Text("Sign Out")
        }
    }
}


struct ChannelRowInMyPage: View {
    @ObservedObject var chanApiModel : ChannelApiModel
    @ObservedObject var toUIColor = HexStringToUIColor()
    var channels : [Channels] { return chanApiModel.channelsSavedArray }
    var body: some View {
   
        
            ScrollView {
                Text("My Favori Channels").font(.largeTitle).padding(.leading).padding(.trailing).background(Color.red).foregroundColor(Color.white).cornerRadius(14)
                ForEach(Array(channels.enumerated()), id:\.offset){ index, item in
                    let renk = toUIColor.hexStringToUIColor(hex: "#\(item.color ?? "")")
                        NavigationLink {
                            RadioView(indexItem: index, viewModel: chanApiModel, channe: channels)
                        } label: {
                            HStack {
                                    AsyncImage(url: URL(string: item.imagetemplate ?? "")){img in
                                        img.resizable().scaledToFit().frame(width: 90, height: 90, alignment: .center)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                VStack{
                                    Text(item.name ?? "").font(.system(size: 18, weight: .bold, design: .default)).foregroundColor(.white)
                                    Text(item.channeltype ?? "").font(.system(size: 11, weight: .bold, design: .default)).foregroundColor(.white)
                                }.padding(.leading)
                                Spacer()
                                Button(action: {chanApiModel.deleteChannelToSavedInFirebase(channel: item)}) {
                                    Image(systemName: "trash").resizable().scaledToFit().frame(width: 26, height: 26, alignment: .trailing)
                                }.padding(.trailing, 10)
                               
                            }
                        
                        }.border(.white, width: 2).shadow(color: .black, radius: 4).frame(width: UIScreen.main.bounds.width).background(Color(renk))
                
                    }
    }
    }
}



struct ProgramsRowInMyPage: View {
    @EnvironmentObject var progApiModel : ProgramsApi
    var body: some View {
        ScrollView {
            Text("My Favori Programs").font(.largeTitle).padding(.leading).padding(.trailing).background(Color.red).foregroundColor(Color.white).cornerRadius(14)
            ForEach(ProgramsApi.sharedPrograms.favoriInfoArray){ item in
                ZStack{
                    NavigationLink(destination: {ProgramsView(program: item)}, label: {
                            ProgramsRowView(program: item, isDeleteShowing: true)
                    })
                }
            }
        }
    }
}
