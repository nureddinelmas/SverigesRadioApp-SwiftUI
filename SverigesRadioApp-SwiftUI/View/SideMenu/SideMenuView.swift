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
    @State var programid = 0
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
                        case "Home" : ContentView().navigationBarHidden(true)
                        case "Channels" : ChannelsVerticalView()
                        case "Programs" : ProgramsShowView()
                        case "Categories" : CategoriesView(programid: $programid)
                        case "My Page" : if FirebaseActions.sharedUser.userSession != nil {
                            MyPageView()
                        }else {
                            InloggningView().navigationBarHidden(true)
                        }
                        default: ContentView()
                            
                        }
                        
                    } label: {
                        SideMenuOptionsView(viewModel: option)
                    }
                }
                Spacer()
            }
        }.navigationBarHidden(true).frame(width: UIScreen.main.bounds.width)
    }
    
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowing: .constant(true))
    }
}
