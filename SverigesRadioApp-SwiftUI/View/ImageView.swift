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
             .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2, alignment: .center)
             .shadow(radius: 10)
             .clipped().cornerRadius(20).padding(20)
             
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageString: "chat")
            
    }
}
