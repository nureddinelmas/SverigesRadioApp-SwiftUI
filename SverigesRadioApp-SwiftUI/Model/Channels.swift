//
//  Channels.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-12.
//

import Foundation
import Firebase
import SwiftUI

struct Response: Codable {
    var copyright : String
    var channels:[Channels]
}

struct Channels : Codable, Identifiable {
    var image : String?
    var imagetemplate : String?
    var color : String?
    var tagline : String?
    var siteurl : String?
    var liveaudio : LiveAudio
    var scheduleurl: String?
    var channeltype : String?
    var xmltvid : String?
    var id : Int
    var name : String?
    var isSaved : Bool?
}


struct LiveAudio: Codable, Identifiable{
    var id : Int
    var url : String
    var statkey : String
}


// completion: @escaping ([Response]) -> ()
class ChannelApiModel: ObservableObject {
    let db = Firestore.firestore()
    let currentChannel = 0
    @Published var channels = [Channels]()
    @Published var channelsSavedArray = [Channels]()
   
    
    init (){
        self.getChannels()
        favoriChannelListListener()
    }
    
    func saveChannelFavorite(channel: Channels) {
       
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        do {
            _ = try db.collection("Users").document(currentUserUid).collection("ChannelFavorites").addDocument(from: channel)
        } catch {
            print("save Channels Favortite Error!")
        }
    }
    
    
    
    
    func getChannels() {
        
        guard let url = URL(string: Constants.channelsURL) else {return}

        URLSession.shared.dataTask(with: url){ data,response,error in

            guard let data = data, error == nil else {return}
            DispatchQueue.main.async {
                if let result = try? JSONDecoder().decode(Response.self, from: data){
                    self.channels = result.channels


                }
            }
               
        }
        .resume()
    }
    
    
    
    func getChannel(){
        guard let url = URL(string: "https://api.sr.se/api/v2/channels?format=json") else { return }

        URLSession.shared.dataTask(with: url){ data, response, error in

            guard let data = data, error == nil else { return }
    
//            guard let jsonResponse = try! JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {return}


//            if let channels = jsonResponse["channels"] as? [[String:Any]]{
//
//                for channel in channels {
//                    name.append(channel["name"] as! String)
//                }
//
//                for i in name {
//                    print(i)
//                }
//
//            }
          
            let _ = try? JSONDecoder().decode([Response].self, from: data)

        }
        .resume()
        
    }
    
    
    func saveChannelFavorite(channelFavori: Channels) {
        
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        do {
            _ = try db.collection("Users").document(currentUserUid).collection("ChannelsFavorite").document(String(channelFavori.id)).setData(from: channelFavori)

            saveFavoriIsSaved(documentId: "\(channelFavori.id)")
         
        } catch {
            print("save Channels Favortite Error!")
        }
    }
    
    
    
    func checkChannelHasBeenSaved(channelFavori: Channels){
 
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        db.collection("Users").document(currentUserUid).collection("ChannelsFavorite").whereField("id", isEqualTo: channelFavori.id).getDocuments { snapshot, error in

            if ((snapshot?.documents.isEmpty) == true) {
                self.saveChannelFavorite(channelFavori: channelFavori)
            }
        }
        }
    
    
    
    func saveFavoriIsSaved (documentId : String){
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }

        db.collection("Users").document(currentUserId).collection("ChannelsFavorite").document(documentId).updateData(["isSaved" : true])

    }
    
    
    func favoriChannelListListener () {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }

        
        COLLECTION_USERS.document(currentUserId).collection("ChannelsFavorite").addSnapshotListener { snapshot, error in
     
            guard let documents = snapshot?.documents else { return }
            self.channelsSavedArray = documents.compactMap({ try? $0.data(as: Channels.self) })
            
            }

    }
    
    
    func deleteChannelToSavedInFirebase(delChannel : Channels) {
        guard let currentUserId = Auth.auth().currentUser?.uid else {return}
        
        COLLECTION_USERS.document(currentUserId).collection("ChannelsFavorite").document(String(delChannel.id)).delete { err in
            if let err = err {
                print("\(err)")
            } else {
                print("Channels has been deleted")
            }
        }
    }
    
    
    func checkToChannelIsSaved(channel: Channels) -> Bool {
        for item in channelsSavedArray {
            if channel.id == item.id {
                return true
            }
        }
      
        return false
    }
    
}

