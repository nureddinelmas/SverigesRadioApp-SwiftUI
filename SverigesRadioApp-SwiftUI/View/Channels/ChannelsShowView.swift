//
//  ChannelsShowView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-17.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChannelsShowView: View {
    @EnvironmentObject var apiModel : ChannelApiModel
    @ObservedObject var toUIColor = HexStringToUIColor()
    @Binding var searchText : String
    var channelsFilter : [Channels] { return apiModel.channels.filter({"\($0)".contains(searchText) || searchText.isEmpty}) }
    
    var body: some View {
        VStack{
        ScrollView(.horizontal){
            HStack{
                ForEach(Array(channelsFilter.enumerated()), id: \.offset){ index, item in
                        NavigationLink {
                            RadioButtonsView(indexItem: index, channe: channelsFilter)
                        } label: {
                            let renk = toUIColor.hexStringToUIColor(hex: "#\(item.color ?? "")")
                            ZStack {
                                VStack{
                                    
                                    WebImage(url: URL(string: item.imagetemplate ?? ""))
                                         .resizable()
                                         .aspectRatio(contentMode: .fill)
                                         .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.1, alignment: .center)
                                         .shadow(radius: 10)
                                         .clipped().cornerRadius(20).padding(20)
                                    Text(item.name!).font(.system(size: 18, weight: .bold, design: .default)).foregroundColor(.white)
                                    Text(item.channeltype!).font(.system(size: 13, weight: .bold, design: .default)).padding(.bottom).foregroundColor(.white)
                                }
                            }.border(.white, width: 2).shadow(color: .black, radius: 4).background(Color(renk))
                           
                        }
                        
                }
                     
                }

        }
        }
    }   
}
