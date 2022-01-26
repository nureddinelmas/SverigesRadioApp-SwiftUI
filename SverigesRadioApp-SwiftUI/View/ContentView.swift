//
//  ContentView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-12.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @State var myChannel:Channels?

    @State private var isShowing = false

    var body: some View {
        NavigationView {
            ZStack {
                if isShowing {
                    SideMenuView(isShowing: $isShowing)
                }
                HomeView()
                    .cornerRadius(isShowing ? 20 : 10)
                    .offset(x: isShowing ? 250 : 0, y: isShowing ? 44 : 0)
                    .scaleEffect(isShowing ? 0.8 : 1)
                    .navigationBarItems(leading: Button(action: {
                        withAnimation(.spring()) {
                            isShowing.toggle()
                        }
                    }, label: {
                        Image(systemName: "list.bullet")
                    }))
                    .navigationTitle("Sveriges Radio")
                    .navigationBarTitleDisplayMode(.inline)
                  
            }.onAppear {
                isShowing = false
                
            }
            
                }
        }

      }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4 ){
            Divider()
            ChannelsShowView()
            
            Divider()
            ProgramsShowView().ignoresSafeArea()
            Spacer()
        }

    }
}
