//
//  ChannelsVerticalView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-19.
//

import SwiftUI

struct ChannelsVerticalView: View {
    @StateObject var apiModel = ApiModel()
    @ObservedObject var toUIColor = HexStringToUIColor()
    @State private var searchText = ""
    @State var isAddedFavorite = false

    var channelsFilter : [Channels] { return apiModel.channels.filter({"\($0)".contains(searchText) || searchText.isEmpty}) }
    
    var body: some View {
            SwiftUI.List {
                ForEach(channelsFilter.prefix(20) ){ item in
                                    let renk = toUIColor.hexStringToUIColor(hex: "#\(item.color ?? "")")
                                        NavigationLink {
                                            ChannelsView(myChannel: item)
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
                                            }.padding(.horizontal, 4)
                                        
                                        }.border(.white, width: 2).shadow(color: .black, radius: 12).background(Color(renk)).swipeActions {
                                            Button(action: {
                                                
                                                if FirebaseActions.sharedUser.userSession != nil {
                                                    apiModel.checkChannelHasBeenSaved(channelFavori: item)
                                                }
                                               
                                                
                                            }, label: {
                                               
                                                VStack{
                                                    if FirebaseActions.sharedUser.userSession != nil {
                                                        Text("Add Favorite")
                                                        Image(systemName: "heart.fill")
                                                    } else {
                                                        Text("Please Login in")
                                                    }
                                                   
                                                    
                                                }
                                                
                                            })
                                        }.tint(Color.blue)
                                
                                    }.searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Search a channel...")
                            .navigationBarTitle("Channels")                     
                    }
    }
    
    
    

    
    
}

struct ChannelsVerticalView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelsVerticalView()
    }
}
