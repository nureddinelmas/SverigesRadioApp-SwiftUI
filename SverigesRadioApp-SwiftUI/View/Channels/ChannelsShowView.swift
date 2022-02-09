//
//  ChannelsShowView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-17.
//

import SwiftUI

struct ChannelsShowView: View {
    @ObservedObject var apiModel = ChannelApiModel()
    @ObservedObject var toUIColor = HexStringToUIColor()
    @Binding var searchText : String
    var channels : [Channels] { return apiModel.channels.filter({ "\($0)".contains(searchText) || searchText.isEmpty}) }
    
    var body: some View {
        VStack{
        ScrollView(.horizontal){
            HStack{
                ForEach(Array(channels.enumerated()), id: \.offset){ index, element in
                        NavigationLink {
                            RadioButtonsView(apiChannelModel: apiModel, indexItem: index, whichArray: true)
                        } label: {
                            let renk = toUIColor.hexStringToUIColor(hex: "#\(channels[index].color ?? "")")
                            ZStack {
                                VStack{
                                    ImageView(imageString: channels[index].imagetemplate ?? "")
                                    Text(channels[index].name!).font(.system(size: 18, weight: .bold, design: .default)).foregroundColor(.white)
                                    Text(channels[index].channeltype!).font(.system(size: 13, weight: .bold, design: .default)).padding(.bottom).foregroundColor(.white)
                                }
                            }.border(.white, width: 2).shadow(color: .black, radius: 4).background(Color(renk))
                           
                        }
                        
                }
                     
                }

        }
        }
    }   
}
