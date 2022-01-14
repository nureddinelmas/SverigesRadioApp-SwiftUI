//
//  Channels.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-12.
//

import Foundation

struct Response: Decodable {
    var copyright : String
    var channelsem:[Channels1]
    var pagination:[Pagination]
}

struct Channels1: Decodable {
    var channels:[Channels]
}
struct Pagination : Decodable{
    var page : Int
    var size : Int
    var totalhits : Int
    var totalpages : Int
    var nextpage : String
}



struct Channels : Decodable {
    var image : String
    var imagetemplate : String
    var color : String
    var tagline : String
    var siteurl : String
    var liveaudio : [LiveAudio]
    var scheduleurl: String
    var xmltvid : String
    var id : Int
    var name : String
}


struct LiveAudio: Decodable, Identifiable{
    var id : Int
    var url : String
    var statkey : String
}


struct Posts: Hashable, Codable, Identifiable{
    
//     This is an exempel for mig. https://jsonplaceholder.typicode.com/posts
    var userId : Int
    var id : Int
    var title : String
    var body : String
}

// completion: @escaping ([Response]) -> ()
class ApiModel: ObservableObject {
    
   
    func getChannels(){
        guard let url = URL(string: "https://api.sr.se/api/v2/channels?format=json") else {return}
  
        URLSession.shared.dataTask(with: url){data,response,error in
            guard let data = data, error == nil else {return}
            print("one")
            print("data -> \(data.description)")
            
                if let results = try? JSONDecoder().decode([Response].self, from: data){
                print("two")
                print(results)
                }
        }
        .resume()
    }
    
    
    
//    func getChannels2() async{
//        guard let url = URL(string: "https://api.sr.se/api/v2/channels?format=json") else {return}
//
//        do {
//            try await URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
//                let kanal = try JSONDecoder().decode([Channels].self, from: data)
//                print(kanal)
//            })
////            let (data, response) = try await URLSession.shared.data(from: url)
////            let channelse = try JSONDecoder().decode([Response].self, from: data)
//
//
//
//        }catch{
//            print("error")
//        }
//    }
    
    func getChannel(){
        guard let url = URL(string: "https://api.sr.se/api/v2/channels?format=json") else { return }

        print("one")
        URLSession.shared.dataTask(with: url){ data, response, error in
           print("two")
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
          
            let result = try? JSONDecoder().decode([Response].self, from: data)
            print("dort")
            print(result)
            if let result = result {
                print("bes")
                print(result)

            }
        }
        .resume()
        
    }
}

