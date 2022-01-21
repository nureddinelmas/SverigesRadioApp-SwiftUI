//
//  CategoriesModel.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-21.
//

import Foundation
import SwiftUI
enum CategoriesModel: Int, CaseIterable {
    case kulturochnöje
    case sport
    case nyheter
    case ekonomi
    case newsinotherlanguages
    case vetenskapandmiljo
    case livsaskadning
    case musik
    case samhalle
    case dokumentar
    case allcategories
    
    var id : Int {
        switch self {
        case .kulturochnöje: return 3
        case .sport: return 10
        case .nyheter: return 68
        case .ekonomi: return 135
        case .newsinotherlanguages: return 11
        case .vetenskapandmiljo: return 12
        case .livsaskadning: return 4
        case .musik: return 5
        case .samhalle: return 7
        case .dokumentar: return 82
        case .allcategories: return 0
        }
    }
    
    var name : String {
        switch self {
        case .kulturochnöje: return "Kultur/Nöje"
        case .sport: return "Sport"
        case .nyheter: return "Nyheter"
        case .ekonomi: return "Ekonomi"
        case .newsinotherlanguages: return "News in other languages"
        case .vetenskapandmiljo: return "Vetenskap/Miljö"
        case .livsaskadning: return "Livsåskådning"
        case .musik: return "Musik"
        case .samhalle: return "Samhälle"
        case .dokumentar: return "Dokumentär"
        case .allcategories: return "All Categories"
        }
    }

}
