//
//  Users.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-16.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Users: Codable, Identifiable {
    @DocumentID var id : String?
    var userName : String
    var name : String
    var surname: String
    var email : String
    
}

class FirebaseActions: ObservableObject {
    @Published var users = [Users]()
    var db = Firestore.firestore()

    func createMember(email: String, password: String, user: Users) -> Bool{
        var responseCreateMember = false
        Auth.auth().createUser(withEmail: email, password: password) { [self] result, error in
            guard let _ = result, error == nil else {return}
            guard let currentUid = Auth.auth().currentUser?.uid else {return}
            do {
                _ = try db.collection("Users").document(currentUid).setData(from: user)
                responseCreateMember = true
            } catch {
                print("Error")
            }
        }
        print("responseCreateMember -> \(responseCreateMember)")
        return responseCreateMember
    }
    
    func signIn(email: String, password : String) -> Bool{
        var responseSignin = false
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard let _ = result, error == nil else {return}
            guard let _ = Auth.auth().currentUser?.uid else {return}
            responseSignin = true
        }
        return responseSignin
    }
}
