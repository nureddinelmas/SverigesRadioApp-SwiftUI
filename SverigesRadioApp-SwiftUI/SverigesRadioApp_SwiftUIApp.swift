//
//  SverigesRadioApp_SwiftUIApp.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-12.
//

import SwiftUI
import Firebase

@main
struct SverigesRadioApp_SwiftUIApp: App {
    init () {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
