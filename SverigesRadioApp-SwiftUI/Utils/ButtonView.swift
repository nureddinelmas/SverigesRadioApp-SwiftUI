//
//  ButtonView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-02-11.
//

import SwiftUI

struct ButtonView1 : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.3), value: configuration.isPressed)
//            .padding()
//            .background(Color(red: 0.3, green: 0.6, blue: 0.5))
//            .clipShape(Capsule())
//            .foregroundColor(Color.white)
//            .font(.system(size: 20, design: .rounded))

    }
}

