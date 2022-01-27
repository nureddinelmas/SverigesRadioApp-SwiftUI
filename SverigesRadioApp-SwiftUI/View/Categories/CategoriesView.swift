//
//  CategoriesView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-19.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject var apiProgram = ProgramsApi()

    @Binding var programid : Int

    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var body: some View {
            MenuInCategoryView(programid: $programid)
            SwiftUI.ScrollView {
                ZStack {
                    RoundedRectangle(cornerRadius: 8).foregroundColor(.white)
                        .shadow(radius: 4, y: 1).frame(width: width - 2, height: height * 3, alignment: .center)
                    VStack {
                        if programid == 0 {
                            CategoryAllView(apiProgram: apiProgram)
                        } else {
                            CategoryOneView(apiProgram: apiProgram, programid: $programid)
                        }
                    }
                            
                }
            }

}

}

struct CategoryAllView : View {
    @ObservedObject var apiProgram : ProgramsApi
    @State var isShowMoreCategory = 50
    @State var isShowing = false
    
    
    var body: some View {
        
      ForEach(apiProgram.programs.indices, id:\.self){index in
        
            if index > 0 && index < isShowMoreCategory {
        
             if apiProgram.programs[index].programcategory?.id != nil {
                  NavigationLink {
                     ProgramsView(programs: apiProgram.programs[index])
                         } label: {
                             CellOfCategoryView(program: apiProgram.programs[index])
                             Spacer()
        
                 }
         }
       }
        
    }
        Divider()
        Button{
        isShowMoreCategory += 10
        } label:{
        HStack{
        Image(systemName: "arrow.down.circle.fill").padding(.trailing, 10)
        Text("Show more").padding(.trailing, 10)
      }.foregroundColor(Color.white).background(Color.red).cornerRadius(20)
    }
}
    
}



struct CategoryOneView : View {
    
    @ObservedObject var apiProgram : ProgramsApi
    @Binding var programid : Int
    
    var body: some View {
        
        ForEach(apiProgram.programs){item in
           
           if item.programcategory?.id == programid {
                           NavigationLink {
                               ProgramsView(programs: item)
                           } label: {
                               CellOfCategoryView(program: item)
                           }
                
            }
               
    }
        
    }
}


struct CellOfCategoryView : View {
    @State var program : Programs
    var body : some View {
        VStack(alignment: .center){

            AsyncImage(url: URL(string: program.programimagetemplate )){ima in
                ima.resizable().scaledToFit()
                   } placeholder: {
                         ProgressView()
                 }
                    

            Text(program.name ?? "" ).font(.system(size: 20, weight: .bold, design: .default))
            Text(program.description ?? "")
                    Text("Categori : \(program.programcategory?.name ?? "")")

                }.foregroundColor(.black)
    }
}

