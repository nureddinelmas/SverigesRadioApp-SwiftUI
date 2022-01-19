//
//  Programs.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-13.
//

import Foundation

struct ProgramIntro: Decodable{
    var copyright:String
    var programs:[Programs]
//    var pagination:Pagination
}

struct Programs: Decodable, Identifiable{
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
}

struct ChannelProgram : Decodable {
    var id : Int
    var name: String
}
struct ProgramCategory : Decodable {
    var id: Int
    var name : String
}

struct SocialMediaPlatform : Decodable {
    var platform : String
    var platformurl : String
}

class ProgramsApi: ObservableObject{
    
    @Published var programs = [Programs]()
    
    
    init (){
        getProgramsData()
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
    
}
