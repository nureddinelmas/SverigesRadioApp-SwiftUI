//
//  SideMenuHeaderView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-18.
//

import SwiftUI
import Firebase

struct SideMenuHeaderView: View {
    @Binding var isShowing: Bool
    @EnvironmentObject var usersActions : FirebaseActions

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button {
                withAnimation(.spring()){
                    isShowing.toggle()
                }
                
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 32, height: 32)
                    .foregroundColor(.white)
                    .padding()
            }

            VStack(alignment: .leading){
                Text("Sveriges Radio")
                    .font(.system(size: 24, weight: .semibold)).padding(.bottom, 10)
                Text(getUser()).font(.system(size: 14))
                HStack(spacing: 12){
                    Spacer()
                }
                  Spacer()
            }.padding()
        }
    }
    
    func getUser() -> String {
//        usersActions.getUsersData()
        usersActions.getCurrentUser()
        if usersActions.userSession != nil {
            guard let currentUser = usersActions.currentUser else {return "Anonymous"}
            return "\(currentUser.fullname)"
//            for i in usersActions.users{
//                return "\(i.name) \(i.surname)"
//
//            }
            
        }
      
        return "Anonymous"
    }
}

struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuHeaderView(isShowing: .constant(true))
    }
}
