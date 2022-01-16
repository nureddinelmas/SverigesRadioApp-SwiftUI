//
//  ImageViewSmall.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-14.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageViewSmall: View {
    @State var imageString : String = ""
    var body: some View {
               WebImage(url: URL(string: imageString))
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.1)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
    }
}

struct ImageViewSmall_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewSmall()
    }
}
