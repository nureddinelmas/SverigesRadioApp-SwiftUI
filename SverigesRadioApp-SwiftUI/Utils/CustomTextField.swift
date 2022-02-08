//
//  CustomTextField.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-02-07.
//

import SwiftUI
import Firebase

struct CustomTextField: View {
    @Binding var text : String
    let placeholder : Text
    let imagename : String
    
    var body: some View {
        ZStack (alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundColor(Color(.init(white: 1, alpha: 0.8))).padding(.leading, 40)
            }
            
            HStack {
                Image(systemName: imagename)
                    .resizable().scaledToFit().frame(width: 20, height: 20)
                    .foregroundColor(.white)
                
                TextField("", text: $text).disableAutocorrection(true)
            }
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""), placeholder: Text("Email"), imagename: "envelope")
    }
}
