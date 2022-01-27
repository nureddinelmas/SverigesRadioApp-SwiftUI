//
//  SearchBarView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-24.
//

import SwiftUI

struct SearchBarView: View {
    @State var searchText = ""
    @State var isCancel = false
    var body: some View {
        HStack{
            TextField("Search", text: $searchText).padding(.trailing, 20).padding(.leading, 50).frame(width : UIScreen.main.bounds.width).onTapGesture {
                isCancel.toggle()
            }
            Spacer()
            Image(systemName: isCancel ? "xmark" : "").padding(.trailing, 40).onTapGesture {
                isCancel.toggle()
            }
        }
        
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView().previewLayout(.sizeThatFits)
    }
}
