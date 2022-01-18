//
//  MenuView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-18.
//

import SwiftUI
import Firebase

struct MenuView: View {
    @State var currentID = Auth.auth().currentUser?.uid
    @State var showingSheet = false
    @State var menuString = "Sign in"
    @ObservedObject var currentActions = FirebaseActions()
    var body: some View {
            Text("Olmadi")
        }


        }
        
//    func signOut() {
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//            menuString = "Sign in"
//        } catch {
//            print("Error")
//        }
//
//    }
//
//    private func isSignIn() -> String {
//        var string : String = ""
//        if currentID == nil {
//            string = "person.circle"
//        } else {
//            for i in currentActions.users {
//                string = "\(i.userName)"
//            }
//        }
//
//        return string
//    }
    

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
