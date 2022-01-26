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

    init () {
        getUsersData()  
    }
    
    
    func createMember(email: String, password: String, user: Users) -> Bool{
   
        var responseCreateMember = false

        Auth.auth().createUser(withEmail: email, password: password) { [self] result, error in

            guard let _ = result, error == nil else {return}
    
            do {
                _ = try db.collection("Users").document(Auth.auth().currentUser!.uid).setData(from: user)

                responseCreateMember = true
            } catch {
                print("Error")
            }
        }
        print("responseCreateMember -> \(responseCreateMember)")
        return responseCreateMember
    }
    

    
    
    func getUsersData(){
        guard let currentUser = Auth.auth().currentUser?.uid else { return }
        
        db.collection("Users").document(currentUser).addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot, error == nil else { return }
                let result = Result {
                    try snapshot.data(as: Users.self)
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

            self.objectWillChange.send()
            
            
        }
    }
    

    
}
