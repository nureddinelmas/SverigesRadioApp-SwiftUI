//
//  LikeButtonView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-02-17.
//

import SwiftUI

struct LikeButtonChannelView: View {

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
                Image(systemName: viewModel.isSaved ? "heart.fill" : "heart").foregroundColor(viewModel.isSaved ? .red : .white).shadow(color: viewModel.isSaved ? .black : .white, radius: 4).font(.system(size: 23))

            }

    }
}
