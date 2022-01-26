//
//  LoginView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-17.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var currentID = Auth.auth().currentUser?.uid
    @State private var showingSheet = false
    @ObservedObject var usersActions = FirebaseActions()
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
        var string : String = ""
        if currentID == nil {
            string = "person.circle"
        } else {
            for i in usersActions.users {
                string = "\(i.userName)"
            }
        }
        
        return string
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().previewLayout(.sizeThatFits)
    }
}
