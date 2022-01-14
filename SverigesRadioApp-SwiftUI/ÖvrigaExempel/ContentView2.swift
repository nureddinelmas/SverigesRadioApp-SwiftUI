//
//  ContentView2.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-13.
//

import SwiftUI

struct ContentView2: View {
   @ObservedObject var myapi = MyApi()
    var body: some View {
        Text("Hej").onAppear {
            myapi.getData()
        }
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
