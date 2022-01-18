//
//  SideMenuView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-18.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing : Bool
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack{
//                Header
                SideMenuHeaderView(isShowing: $isShowing).foregroundColor(.white)
                    .frame(height: 100)
//                Cell items
                ForEach(SideMenuViewModel.allCases, id:\.self){option in
                    NavigationLink {
                        switch option.title {
                        case "Profile": ChannelsShowView()
                        case "Channels" : ChannelsShowView()
                        case "Programs" : ProgramsShowView()
                        default:
                           LoginView()
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
