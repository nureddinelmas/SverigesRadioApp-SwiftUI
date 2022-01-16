//
//  Styles.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-16.
//

import Foundation
import SwiftUI

struct ButtonView : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0.3, green: 0.6, blue: 0.5))
            .clipShape(Capsule())
            .foregroundColor(Color.white)
            .font(.system(size: 20, weight: .light, design: .rounded))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.3), value: configuration.isPressed)
    }
}
