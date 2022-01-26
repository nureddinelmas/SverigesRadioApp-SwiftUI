//
//  Programs.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-13.
//

import Foundation
import SwiftUI
import Firebase

struct ProgramIntro: Codable{
    var copyright:String
    var programs:[Programs]
//    var pagination:Pagination
}

struct Programs: Codable, Identifiable{
    var description: String? = "No Description"
    var programcategory:ProgramCategory?
    var broadcastinfo: String?
    var email : String?
    var phone : String?
    var programurl: String?
    var programslug : String?
    var programimage: String?
    var programimagetemplate: String?
    var programimagewide: String?
    var programimagetemplatewide : String?
    var socialimage : String?
    var socialimagetemplate: String?
    var socialmediaplatforms:[SocialMediaPlatform]?
    var channel:ChannelProgram?
    var archived : Bool
    var hasondemand : Bool
    var haspod : Bool
    var responsibleeditor : String?
    var id : Int?
    var name : String?
    var isSaved : Bool?
}

struct ChannelProgram : Codable {
    var id : Int
    var name: String
}
struct ProgramCategory : Codable {
    var id: Int
    var name : String
}

struct SocialMediaPlatform : Codable {
    var platform : String
    var platformurl : String
}


struct ProgramsInfoDetails : Codable, Identifiable {
    var id : Int
    var isSaved : Bool
}

class ProgramsApi: ObservableObject{
    let db = Firestore.firestore()
    @Published var programs = [Programs]()
    @Published var favoriInfoArray = [Programs]()

    
    init () {
        
        getProgramsData()
        favoriProgramsListListener()
        
    }
     
     
    
    func getProgramsData(){
        guard let url = URL(string: Constants.programsURL ) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {return}
            DispatchQueue.main.async {
                if let programs = try? JSONDecoder().decode(ProgramIntro.self, from: data){
                    self.programs = programs.programs
                }
            }
           
          
        }.resume()
    }
    
    
    func saveProgramsFavorite(progFavori: Programs) {
        
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        do {
            _ = try db.collection("Users").document(currentUserUid).collection("ProgramsFavorite").document(String(progFavori.id!)).setData(from: progFavori)

            saveFavoriIsSaved(documentId: "\(progFavori.id!)")
         
        } catch {
            print("save Channels Favortite Error!")
        }
    }
    
    func checkProgramHasBeenSaved(progFavori: Programs){
 
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        db.collection("Users").document(currentUserUid).collection("ProgramsFavorite").whereField("id", isEqualTo: progFavori.id!).getDocuments { snapshot, error in

            if ((snapshot?.documents.isEmpty) == true) {
                self.saveProgramsFavorite(progFavori: progFavori)
            }
        }
        }
    
    
    
    func saveFavoriIsSaved (documentId : String){
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }

        db.collection("Users").document(currentUserId).collection("ProgramsFavorite").document(documentId).updateData(["isSaved" : true])

    }
    
    
    func favoriProgramsListListener () {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        db.collection("Users").document(currentUserId).collection("ProgramsFavorite").addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else { return }
            
            for document in snapshot.documents {
                let result = Result {
                    try document.data(as: Programs.self)
                }
            
                switch result {
                case .success(let success):
                    if let success = success {
                     self.favoriInfoArray.append(success)
                    }
                case .failure(let failure):
                        print("Failed \(failure)")
                }
            
            }
                    self.objectWillChange.send()
            }

    }
    
    
    
    func checkDocumentId (docId : Int) -> Bool {
        var resultDocId : Bool?
        for i in favoriInfoArray {
            
            if i.id == docId {
                resultDocId = true
            } else {
                resultDocId = false
            }
        }
        
        return resultDocId ?? true
    }
    
    
    
    
    
        
    }

