//
//  ContentView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-12.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var apiModel = ApiModel()
    @State var apiModelWeather = ApiWeather()
 
    var body: some View {
     
        Text("Hej").task {
            
            apiModelWeather.getData()
        }

       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
