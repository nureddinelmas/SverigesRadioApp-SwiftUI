//
//  RadioViewModel.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-02-17.
//

import SwiftUI
import Firebase

class RadioViewModel : ObservableObject {
    @Published var channel:Channels
    @Published var isSaved : Bool = false
    
    init (channel: Channels){
        self.channel = channel
        check()
    }
  
    func check(){
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
     
        COLLECTION_USERS.document(currentUserId).collection("ChannelsFavorite").document(String(channel.id)).addSnapshotListener({ snapshot, error in
            guard let isSaved = snapshot?.exists else { return }
            self.isSaved = isSaved
        })

    }
    
    
    func saveChannelFavorite() {
        
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        do {
            _ = try COLLECTION_USERS.document(currentUserUid).collection("ChannelsFavorite").document(String(channel.id)).setData(from: channel)
         
        } catch {
            print("save Channels Favortite Error!")
        }
    }
    
    
    func deleteChannelToSavedInFirebase() {
        guard let currentUserId = Auth.auth().currentUser?.uid else {return}
        
        COLLECTION_USERS.document(currentUserId).collection("ChannelsFavorite").document(String(channel.id)).delete { err in
            if let err = err {
                print("\(err)")
            } else {
                print("Channels has been deleted")
            }
        }
    }
    
}
