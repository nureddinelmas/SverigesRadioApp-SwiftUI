//
//  ChannelsVerticalView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-19.
//

import SwiftUI

struct ChannelsVerticalView: View {
    @StateObject var apiModel = ChannelApiModel()
    @ObservedObject var toUIColor = HexStringToUIColor()
    @State private var searchText = ""
    @State var isAddedFavorite = false


    var channelsFilter : [Channels] { return apiModel.channels.filter({"\($0)".contains(searchText) || searchText.isEmpty}) }
    
    var body: some View {
        MyChannelView(searchText: $searchText).searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Söka en kanal...")
    }
    
    
    

    
    
}


struct MyChannelView: View {
    @StateObject var apiModel = ChannelApiModel()
    @ObservedObject var toUIColor = HexStringToUIColor()
    @Binding var searchText : String
    @State var isAddedFavorite = false
    @State var isShowMore = 10

    var channelsFilter : [Channels] { return apiModel.channels.filter({"\($0)".contains(searchText) || searchText.isEmpty}) }
    var body: some View {
            SwiftUI.ScrollView {
                ForEach(Array(channelsFilter.prefix(isShowMore).enumerated()), id:\.offset){ index, item in
                                    let renk = toUIColor.hexStringToUIColor(hex: "#\(item.color ?? "")")
                                        NavigationLink {
                                            RadioButtonsView(indexItem: index, channe: channelsFilter)
                                        } label: {
                                            HStack {
                                                    AsyncImage(url: URL(string: item.imagetemplate ?? "")){img in
                                                        img.resizable().scaledToFit().frame(width: 90, height: 90, alignment: .center)
                                                    } placeholder: {
                                                        ProgressView()
                                                    }
                                                VStack {
                                                    
                                                    Text(item.name!).font(.system(size: 18, weight: .bold, design: .default)).foregroundColor(.white)
                                                    Text(item.channeltype!).font(.system(size: 11, weight: .bold, design: .default)).foregroundColor(.white)
                                                }.padding(.leading)
                                                Spacer()
                                                MyLikeButtonView(apiChannelModel: apiModel, chn: item).padding(.trailing, 10)
                                            }.padding(.horizontal, 4)
                                            
                                            
                                        }.border(.white, width: 2).shadow(color: .black, radius: 12).background(Color(renk)).padding(.trailing, 10).padding(.leading, 10)
                  
                                    }
                            .navigationBarTitle("Channels")
                Button{
                   isShowMore += 10
               } label: {
                   HStack{
                       Image(systemName: "arrow.down.circle.fill").padding(.trailing, 10)
                       Text("Show more").padding(.trailing, 10)
                   }.foregroundColor(Color.white).background(Color.red).cornerRadius(20)
                   
               }
            }.listStyle(InsetListStyle())
    }
}

struct MyLikeButtonView: View {
    @ObservedObject var apiChannelModel : ChannelApiModel
    @State var chn : Channels
    
    var body: some View {
            Button(action: {
//                Like button Action
                
                       if FirebaseActions.sharedUser.userSession != nil {
                           if apiChannelModel.checkToChannelIsSaved(channel: chn) {
                               apiChannelModel.deleteChannelToSavedInFirebase(delChannel: chn)
                           } else {
                               apiChannelModel.checkChannelHasBeenSaved(channelFavori: chn)
                           }
                          
                       }
            }) {
                Image(systemName: apiChannelModel.checkToChannelIsSaved(channel: chn) ? "heart.fill" : "heart").foregroundColor(apiChannelModel.checkToChannelIsSaved(channel: chn) ? .red : .white).shadow(color: apiChannelModel.checkToChannelIsSaved(channel: chn) ? .black : .white, radius: 4).font(.system(size: 23)).onAppear {
                    apiChannelModel.favoriChannelListListener()
                }
            }
    }
}

