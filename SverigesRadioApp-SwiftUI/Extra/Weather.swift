//
//  Weather.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-12.
//

import Foundation

struct WeatherResponse: Decodable {
    var list: [List]
    
}
struct List : Decodable {
//    var main : [Main]
    var weather : [Weather]
   
}

struct Main : Decodable{
    var temp :Double
    var feels_like : Double
    var temp_min : Double
    var temp_max : Double
    var pressure : Int
    var sea_level : Int
    var grnd_level : Int
    var humidity : Int
    var tem_kf : Double
}

struct Weather: Decodable {
    var id : Int
    var main : String
    var description: String
    var icon : String
}

class ApiWeather{
    
    func getData(){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?id=524901&appid=0f579c15d5b031b4d67129af05838df0")
        
        URLSession.shared.dataTask(with: url!){data,_,_ in
            let result = try! JSONDecoder().decode(WeatherResponse.self, from: data!)
            
            print(result)
        }
        .resume()
    }
}
