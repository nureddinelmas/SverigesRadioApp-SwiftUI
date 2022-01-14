//
//  Bundle.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-14.
//

import Foundation

class MyApi : ObservableObject{
    func getData(){
        
        guard let path = Bundle.main.path(forResource: "myData", ofType: "json") else {return}
        
        let url = URL(fileURLWithPath: path)
        var result:ResultItem?
        do {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(ResultItem.self, from: jsonData)
            if let result = result {
                print(result)
            }
        } catch{
            print("error!")
        }          
    }
}
