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
    var description: String = "No Description"
    var programcategory:ProgramCategory?
    var broadcastinfo: String?
    var email : String?
    var phone : String?
    var programurl: String?
    var programslug : String?
    var programimage: String?
    var programimagetemplate: String
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
    var name : String

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
    @Published var programs = [Programs]() // Från Json
    @Published var favoriInfoArray = [Programs]() // från Firebase
    

    static let sharedPrograms = ProgramsApi()
    
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
    
    
    func filteredPrograms(_ query : String) -> [Programs]{
   
//        || $0.description.lowercased().contains(lowercasedQuery)
        let lowercasedQuery = query.lowercased()
        let result = programs.filter({ $0.name.lowercased().contains(lowercasedQuery)  })
        print(result)
        return result
    }
    
    
    
    func saveProgramsFavorite(progFavori: Programs) {
        
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        do {
            _ = try COLLECTION_USERS.document(currentUserUid).collection("ProgramsFavorite").document(String(progFavori.id!)).setData(from: progFavori)
         
        } catch {
            print("save Channels Favortite Error!")
        }
    }
    
    func checkProgramHasBeenSaved(progFavori: Programs){
 
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_USERS.document(currentUserUid).collection("ProgramsFavorite").whereField("id", isEqualTo: progFavori.id!).getDocuments { snapshot, error in

            if ((snapshot?.documents.isEmpty) == true) {
                self.saveProgramsFavorite(progFavori: progFavori)
            }
        }
        }
    
    
    
    func favoriProgramsListListener () {

        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_USERS.document(currentUserId).collection("ProgramsFavorite").addSnapshotListener { snapshot, error in
            
            guard let documents = snapshot?.documents else { return }
            self.favoriInfoArray = documents.compactMap({ try? $0.data(as: Programs.self) })
          
            }

    }
    
    func deleteFavoriPrograms (progFavori: Programs) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(currentUserId).collection("ProgramsFavorite").document(String(progFavori.id!)).delete() { err in
            if let err = err {
                print("Error removing document \(err)")
            } else {
                print("Document successfully removed! ")
            }
            
        }
    }
    
    func checkDocumentId (program : Programs) -> Bool {
            for item in favoriInfoArray {
            if item.id == program.id {
                return true
            }
        }
        
       return false
    }
    

    
    func addFavorite (program : Programs) {
        if checkDocumentId(program: program) {
            
            deleteFavoriPrograms(progFavori: program)
            favoriInfoArray.removeAll()
            favoriProgramsListListener()
        } else {
            checkProgramHasBeenSaved(progFavori: program)
        }
    }
    
    
    
    }

