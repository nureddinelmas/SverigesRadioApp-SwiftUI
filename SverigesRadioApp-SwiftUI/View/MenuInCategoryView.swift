//
//  MenuInCategoryView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-21.
//

import SwiftUI

struct MenuInCategoryView: View {
    @Binding var programid:Int
    @State var programname:String = "All Categories"
    var body: some View {
        Menu  {
            ForEach(CategoriesModel.allCases, id:\.self){ option in
                Button(option.name) {
                    programid = option.id
                    programname = option.name
                }
            }
        } label: {
            HStack{
                Text(programname).onAppear {
                    programid = 0
                }
                Image(systemName: "arrow.down.app.fill")
            }.font(.largeTitle).padding(.leading).padding(.trailing).background(Color.red).foregroundColor(Color.white).cornerRadius(14)
           
        }
    }
}


