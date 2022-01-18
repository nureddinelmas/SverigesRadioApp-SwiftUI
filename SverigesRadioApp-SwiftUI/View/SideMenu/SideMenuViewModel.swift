//
//  SideMenuViewModel.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-18.
//

import Foundation
import SwiftUI
enum SideMenuViewModel: Int, CaseIterable {
    case profile
    case channels
    case programs
    case logout
    
    var title : String {
        switch self {
        case .profile: return "Profile"
        case.channels: return "Channels"
        case.programs: return "Programs"
        case.logout: return "Logout"
        }
    }
    
    var imageName: String {
        switch self {
        case .profile: return "person"
        case.channels: return "radio.fill"
        case.programs: return "bubble.left"
        case.logout: return "arrow.left.square"
        }
    }
}
