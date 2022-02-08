
//
//  LoginView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-17.
//

import SwiftUI
import Firebase

struct LoginView: View {

    @State private var showingSheet = false
    @EnvironmentObject var usersActions : FirebaseActions
    var body: some View {
        Button {
            showingSheet.toggle()
        } label: {
            Image(systemName: "person.circle")
            Text(isSignIn())
        }.sheet(isPresented: $showingSheet) {
            InloggningView()
        }
    }
    
    private func isSignIn() -> String {

        if usersActions.userSession == nil {
            return "person.circle"
        } else {
            for i in usersActions.users {
                return "\(i.userName)"
            }
        }
        
        return ""
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().previewLayout(.sizeThatFits)
    }
}
