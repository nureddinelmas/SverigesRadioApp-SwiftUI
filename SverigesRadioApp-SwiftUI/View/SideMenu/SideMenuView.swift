//
//  SideMenuView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-18.
//

import SwiftUI
import Firebase

struct SideMenuView: View {
    @Binding var isShowing : Bool
    let currentId = Auth.auth().currentUser?.uid
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack{
//                Header
                SideMenuHeaderView(isShowing: $isShowing).foregroundColor(.white)
                    .frame(height: 100)
//                Cell items
                ForEach(SideMenuViewModel.allCases, id:\.self){ option in
                    NavigationLink {
                        switch option.title {
                        case "Home" : ContentView()
                        case "Channels" : ChannelsVerticalView()
                        case "Programs" : ProgramsShowView()
                        case "Categories" : CategoriesView()
                        case "My Page" : if currentId != nil {
                            MyPageView()
                        }else {
                            InloggningView()
                        }
                        default: ContentView()
                            
                        }
                        
                    } label: {
                        SideMenuOptionsView(viewModel: option)
                    }

                    

                }
                Spacer()
            }
        }.navigationBarHidden(true)
    }
    
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowing: .constant(true))
    }
}
