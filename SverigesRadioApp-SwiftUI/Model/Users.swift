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

  

struct Users: Identifiable, Decodable, Encodable {
    @DocumentID var id : String?
    var userName : String
    var fullname : String
    var email : String
}


class FirebaseActions: ObservableObject {
    @Published var users = [Users]()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser : Users?
    
    static let sharedUser = FirebaseActions()

    init () {
        getUsersData()
        userSession = Auth.auth().currentUser
        getCurrentUser()
    }
    
    func signout() {
        userSession = nil
        try? Auth.auth().signOut()
    }
    
    func register(user: Users, password: String, completion: @escaping(Bool) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: password) { [self] result, error in
          
            guard let _ = result, error == nil else {return}
            guard let uid = result?.user.uid else { return }

            do {
                _ = try COLLECTION_USERS.document(uid).setData(from: user)
                self.userSession = result?.user
                completion(true)
            } catch {
                print("Error")
            }
            completion(false)
        }
    }
    
    func login(withEmail email: String, password : String, completion: @escaping(Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard let _ = result, error == nil else {return}
           
            guard let user = result?.user else { return }
            self.userSession = user
            completion(true)
           
        }
        
    }
    
    func getCurrentUser(){
        guard let uid = userSession?.uid else {return}
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let snapshot = snapshot else { return }
            guard let user = try? snapshot.data(as: Users.self) else { return }
            
            self.currentUser = user
           
        }

    }
    
    
    
    func getUsersData(){
        
//        guard let currentUser = userSession?.uid else { return }
        
        COLLECTION_USERS.addSnapshotListener { snapshot, err in

//            .addSnapshotListener { snapshot, error in
            self.users.removeAll()
            
            guard let documents = snapshot?.documents else {return}
            self.users = documents.compactMap({ try? $0.data(as: Users.self) })
            

//            guard let snapshot = snapshot, error == nil else { return }
//                let result = Result {
//                    try snapshot.data(as: Users.self)
//                }
//                switch result {
//                case .success(let user):
//                    if let user = user {
//                        self.users.append(user)
//
//                        print(user.name)
//                    } else {
//                        print("Users doesnt exist")
//                    }
//
//                case .failure(let failure):
//
//                        print("Failed \(failure)")
//
//                }
//            self.objectWillChange.send()
//
           
        }
    }
    

    
}
