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
    @StateObject var progApiModel = ProgramsApi()
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
                ForEach(channels.indices){ index in
                    let renk = toUIColor.hexStringToUIColor(hex: "#\(channels[index].color ?? "")")
                        NavigationLink {
                            RadioButtonsView(indexItem: index, channe: channels)
                        } label: {
                            HStack {
                                    AsyncImage(url: URL(string: channels[index].imagetemplate ?? "")){img in
                                        img.resizable().scaledToFit().frame(width: 90, height: 90, alignment: .center)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                VStack{
                                    Text(channels[index].name!).font(.system(size: 18, weight: .bold, design: .default)).foregroundColor(.white)
                                    Text(channels[index].channeltype!).font(.system(size: 11, weight: .bold, design: .default)).foregroundColor(.white)
                                }.padding(.leading)
                                Spacer()
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
            ForEach(progApiModel.favoriInfoArray){ item in
                NavigationLink(destination: {ProgramsView(programs: item)}, label: {  ProgramsRowView(program: item, likeButtonShow: true) })
            }
        }
    }
}
