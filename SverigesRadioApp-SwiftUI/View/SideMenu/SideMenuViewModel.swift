//
//  SideMenuViewModel.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-18.
//

import Foundation
import SwiftUI
enum SideMenuViewModel: Int, CaseIterable {
    case home
    case channels
    case programs
    case categories
    case myPage

    
    var title : String {
        switch self {
        case .home: return "Home"
        case.channels: return "Channels"
        case.programs: return "Programs"
        case.myPage: return "My Page"
        case.categories : return "Categories"
        }
    }
    
    var imageName: String {
        switch self {
        case .home: return "house"
        case.channels: return "radio.fill"
        case.programs: return "bubble.left"
        case.categories : return "list.bullet.rectangle.fill"
        case.myPage: return "doc.richtext.fill"
            
        }
    }
}
