//
//  ChannelsShowView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-17.
//

import SwiftUI

struct ChannelsShowView: View {
    @ObservedObject var apiModel = ApiModel()
    @ObservedObject var toUIColor = HexStringToUIColor()
    var body: some View {
        VStack{
        ScrollView(.horizontal){
            HStack{
                ForEach(apiModel.channels){ item in
                        NavigationLink {
                            ChannelsView(myChannel: item)
                        } label: {
                            let renk = toUIColor.hexStringToUIColor(hex: "#\(item.color ?? "")")
                            ZStack {
                                VStack{
                                    ImageView(imageString: item.imagetemplate ?? "")
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

struct ChannelsShowView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelsShowView().previewLayout(.sizeThatFits)
    }
}
