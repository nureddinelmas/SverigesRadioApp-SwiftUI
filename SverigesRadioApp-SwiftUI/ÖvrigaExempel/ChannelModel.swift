//
//  ChannelModel.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-14.
//

import Foundation

struct Result : Decodable {
    let data : [ResultItem]
}

struct ResultItem: Decodable{
    var image : String
    var imagetemplate : String
    var color : String
    var tagline : String
    var siteurl : String
    var liveaudio : [LiveAudio]
    var scheduleurl: String
    var xmltvid : String
    var id : Int
    var name : String
}
