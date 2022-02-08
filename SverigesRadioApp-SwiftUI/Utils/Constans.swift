//
//  Constans.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-02-02.
//

import Firebase
import SwiftUI

let COLLECTION_USERS = Firestore.firestore().collection("Users")

let color1 : Color = Color(red: 49/256, green: 161/256, blue: 150/256, opacity: 1)
let color2 : Color = Color(red: 255/256, green: 90/256, blue: 0/256, opacity: 1)
let color3 : Color = Color(red: 25/256, green: 169/256, blue: 114/256, opacity: 1)
let color4 : Color = Color(red: 194/256, green: 30/256, blue: 169/256, opacity: 1)

let gran : Gradient = Gradient(colors: [color1, color2, color3, color4])



let gran1 : Gradient = Gradient(colors: [color1, color3])


let gran2 : Gradient = Gradient(colors: [color2, color4])


struct Constants {
    static let channelsURL = "https://api.sr.se/api/v2/channels?format=json&pagination=false"
    static let programsURL = "https://api.sr.se/api/v2/programs?format=json&pagination=false"
    static let programAvsnittURL = "https://api.sr.se/api/v2/episodes/index?format=json&pagination=false&programid="
}

