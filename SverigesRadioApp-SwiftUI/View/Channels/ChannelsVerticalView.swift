//
//  ChannelsVerticalView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-19.
//

import SwiftUI
import Firebase

struct ChannelsVerticalView: View {
    @State private var searchText = ""
    var body: some View {
        MyChannelView(searchText: $searchText).searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Sök en kanal...")
    }
   
}



struct MyChannelView: View {
    @StateObject var apiModel = ChannelApiModel()
    @ObservedObject var toUIColor = HexStringToUIColor()
    @Binding var searchText : String
    @State var isAddedFavorite = false


    var channelsFilter : [Channels] { return apiModel.channels.filter({"\($0)".contains(searchText) || searchText.isEmpty})
        
    }
    var body: some View {
        VStack {
            ScrollView (.vertical) {
                    
                    ForEach(Array(channelsFilter.enumerated()), id:\.offset){ index, item in
                                        let renk = toUIColor.hexStringToUIColor(hex: "#\(item.color ?? "")")
                                            NavigationLink {
                                                RadioView(indexItem: index, viewModel: apiModel, channe: channelsFilter)
                                               
                                            } label: {
                                                HStack {
                                                        AsyncImage(url: URL(string: item.imagetemplate ?? "")){img in
                                                            img.resizable().scaledToFit().frame(width: 90, height: 90, alignment: .center)
                                                        } placeholder: {
                                                            ProgressView()
                                                        }
                                                    VStack {
                                                        
                                                        Text(item.name ?? "Unknown").font(.system(size: 18, weight: .bold, design: .default)).foregroundColor(.white)
                                                        Text(item.channeltype ?? "Unknown information").font(.system(size: 11, weight: .bold, design: .default)).foregroundColor(.white)
                                                    }.padding(.leading)
                                                    Spacer()
                                                    if Auth.auth().currentUser?.uid != nil {
                                                  
                                                        LikeButtonChannelView(chn: item).padding(.trailing, 10)
                                                        
                                                    }
                                                        
                                                }.padding(.horizontal, 4)
                                                
                                                
                                            }.border(.white, width: 2).shadow(color: .black, radius: 12).background(Color(renk)).padding(.trailing, 10).padding(.leading, 10)
                      
                                        }
                                .navigationBarTitle("Channels")

            }.listStyle(InsetListStyle())
        }
    }
}

struct MyLikeButtonView: View {
//    @ObservedObject var apiChannelModel : ChannelApiModel
//    @State var chn : Channels
    @ObservedObject var viewModel : RadioViewModel
    
    init (chn : Channels) {
        self.viewModel = RadioViewModel(channel: chn)
    }
    
    var body: some View {

            Button(action: {
//                Like button Action
                
                      
                           if viewModel.isSaved {
                               viewModel.deleteChannelToSavedInFirebase()
                           } else {
                               viewModel.saveChannelFavorite()
                           }
                          
                       
            }) {
//                Image(systemName: apiChannelModel.checkChannelIsSaved(channel: chn) ? "heart.fill" : "heart").foregroundColor(apiChannelModel.checkChannelIsSaved(channel: chn) ? .red : .white).shadow(color: apiChannelModel.checkChannelIsSaved(channel: chn) ? .black : .white, radius: 4).font(.system(size: 23))
                
                Image(systemName: viewModel.isSaved ? "heart.fill" : "heart").foregroundColor(viewModel.isSaved ? .red : .white).shadow(color: viewModel.isSaved ? .black : .white, radius: 4).font(.system(size: 23))

            }

    }
}




