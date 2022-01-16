//
//  ParseController.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-15.
//

import Foundation
struct Item {
    var eposideid: Int
    var title: String
    var description: String
    var starttimeutc: String
    var endtimeutc : String
    var program : Program
    var channel : Channel
    var imageurl: String
    var imageurltemplate : String
    
    
}

struct Program {
    var id : Int
    var name : String
}

struct Channel {
    var id : Int
    var name : String
}
class ParseController : NSObject, XMLParserDelegate, ObservableObject {
    var items : [Item] = []
    @Published var itemStore: [Item]?
    var channel:[Channels] = []
    
    func loadData(){
        let url = URL(string: "https://api.sr.se/v2/scheduledepisodes?channelid=132")
        let request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("dataTaskWithRequest error \(error)")
                return
            }
            
            guard let data = data else {
                print("dataTaskWithRequest error is nil")
                return
            }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            
            self.itemStore = self.items
            
        }
        
        task.resume()
    }
    
}
