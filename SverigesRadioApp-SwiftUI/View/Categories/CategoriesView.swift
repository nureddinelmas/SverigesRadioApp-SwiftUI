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
    @Binding var programid : Int
    @State var isShowMoreCategory = 20
    
    var body: some View {
        MenuInCategoryView(programid: $programid)
        SwiftUI.ScrollView {
                VStack{
                    if programid == 0 {
                        ForEach(apiProgram.programs.indices, id:\.self){index in
                          
                            if index > 0 && index < isShowMoreCategory {
                              
                                if apiProgram.programs[index].programcategory?.id != nil {
                                                NavigationLink {
                                                    ProgramsView(programs: apiProgram.programs[index])
                                                } label: {
                                                    
                                                    VStack(alignment: .center){
                                                      
                                                            AsyncImage(url: URL(string: apiProgram.programs[index].programimagetemplate ?? "")){ima in
                                                                ima.resizable().scaledToFit()
                                                            } placeholder: {
                                                                ProgressView()
                                                            }
                                                       
                                                        
                                         Text(apiProgram.programs[index].name ?? "").font(.system(size: 20, weight: .bold, design: .default))
                                     Text(isShowing ? ((apiProgram.programs[index].description?.prefix(550))!) + "...less" : ((apiProgram.programs[index].description?.prefix(50))!) + "...more").font(.system(size: 15, weight: .bold, design: .default)).onTapGesture {
                                         isShowing.toggle()
                                 }
                                                        Text("Categori : \(apiProgram.programs[index].programcategory?.name ?? "")")
                                     Divider()
                                                    }
                                                   
                                                }
                                     
                                 }
                            }
                             
                        }
                        
                        Button{
                            isShowMoreCategory += 10
                        } label:{
                            HStack{
                                Image(systemName: "arrow.down.circle.fill").padding(.trailing, 10)
                                Text("Show more").padding(.trailing, 10)
                            }.foregroundColor(Color.white).background(Color.red).cornerRadius(20)
                        }
                    } else {
                        ForEach(apiProgram.programs){item in
                           
                           if item.programcategory?.id == programid {
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

}
    
    
