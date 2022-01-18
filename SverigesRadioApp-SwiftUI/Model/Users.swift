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
    @Published var isOkej : Bool = false
    var db = Firestore.firestore()

    init () {
        getUsersData()  
    }
    
    
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
    
    func signIn(email: String, password : String){
 
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard let _ = result, error == nil else {return}
            guard let _ = Auth.auth().currentUser?.uid else {return}
            self.isOkej = true
        }

    }
    
    
    func getUsersData(){
        
        db.collection("Users").addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot, error == nil else { return }
            for document in snapshot.documents {
                let result = Result {
                    try document.data(as: Users.self)
                }
                switch result {
                case .success(let user):
                    if let user = user {
                        self.users.append(user)
                       
                    } else {
                        print("Users doesnt exist")
                    }
                    
                case .failure(let failure):
    
                        print("Failed \(failure)")
                    
                }
                
            }
        }
    }
    
}
