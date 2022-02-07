//
//  Constans.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-02-02.
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("Users")


struct Constants {
    static let channelsURL = "https://api.sr.se/api/v2/channels?format=json&pagination=false"
    static let programsURL = "https://api.sr.se/api/v2/programs?format=json&pagination=false"
    static let programAvsnittURL = "https://api.sr.se/api/v2/episodes/index?format=json&pagination=false&programid="
}

