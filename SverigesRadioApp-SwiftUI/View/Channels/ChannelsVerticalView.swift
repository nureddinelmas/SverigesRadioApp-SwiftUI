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

    
    var body: some View {
            SwiftUI.List {
                        ForEach(apiModel.channels.filter({"\($0)".contains(searchText) || searchText.isEmpty}) ){ item in
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
                                                VStack{
                                                    Text(item.name!).font(.system(size: 18, weight: .bold, design: .default)).foregroundColor(.white)
                                                    Text(item.channeltype!).font(.system(size: 11, weight: .bold, design: .default)).foregroundColor(.white)
                                                }.padding(.leading).searchable(text: $searchText)
                                            }
                                        
                                        }.border(.white, width: 2).shadow(color: .black, radius: 4).background(Color(renk)).swipeActions {
                                            Button(action: {apiModel.checkProgramHasBeenSaved(channelFavori: item)}, label: {VStack{Text("Add Favorite")
                                                Image(systemName: "star.circle.fill")}})
                                        }.tint(Color.blue)
                                
                                    }
                            .navigationBarTitle("Channels")                     
                    }
    }
    
    
    

    
    
}

struct ChannelsVerticalView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelsVerticalView()
    }
}
