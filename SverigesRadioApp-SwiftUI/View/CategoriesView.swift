//
//  CategoriesView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-19.
//

import SwiftUI

struct CategoriesView: View {
    @ObservedObject var apiProgram = ProgramsApi()
    @State var isShowing = false
    
    var body: some View {
        SwiftUI.ScrollView {
                VStack{
                    Text("Categories").font(.largeTitle).padding(.trailing).padding(.leading).background(Color.red).foregroundColor(Color.white).cornerRadius(14)

                    ForEach(apiProgram.programs){item in
                        if item.programcategory?.id != nil {
                                       NavigationLink {
                                           ProgramsView(programs: item)
                                       } label: {
                                           VStack(alignment: .center){
                                               AsyncImage(url: URL(string: item.programimagetemplate ?? "")){ima in
                                                   ima.resizable().scaledToFit()
                                               } placeholder: {
                                                   ProgressView()
                                               }
                                               
                                              
                                       
                                Text(item.name ?? "").font(.system(size: 20, weight: .bold, design: .default))
                            Text(isShowing ? ((item.description?.prefix(550))!) + "...less" : ((item.description?.prefix(50))!) + "...more").font(.system(size: 15, weight: .bold, design: .default)).onTapGesture {
                                isShowing.toggle()
                        }
                                               Text("Categori : \(item.programcategory?.name ?? "")")
                            Divider()
                               }
                                       }
                            
                        }
                }
    }
    }
}

}
    
    
struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
