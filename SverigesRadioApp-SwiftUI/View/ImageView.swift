//
//  ImageView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-14.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageView: View {
    @State var imageString : String = ""
    var body: some View {
        VStack{
        WebImage(url: URL(string: imageString))
             .resizable()
             .aspectRatio(contentMode: .fill)
             .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.1, alignment: .center)
             .shadow(radius: 10)
             .clipped().cornerRadius(20).padding(20)
//             .shadow(radius: 15)
             
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageString: "chat")
            
    }
}
