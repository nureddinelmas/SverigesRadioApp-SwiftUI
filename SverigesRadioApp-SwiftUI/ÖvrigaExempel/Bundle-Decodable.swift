//
//  Bundle-Decodable.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-13.
//

import Foundation

extension Bundle {
    func decode(_ file: String) -> [String: Channels]{
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode([String:Channels].self, from: data) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        return loaded
    }
    
}
