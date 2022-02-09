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

struct CategoryAllView : View {
    @ObservedObject var apiProgram : ProgramsApi
    @State var isShowMoreCategory = 50
    
    
    var body: some View {
        
        ForEach(apiProgram.programs.prefix(isShowMoreCategory)){item in
        
       if item.programcategory?.id != nil {
          NavigationLink {
             ProgramsView(programs: item)
               } label: {
                CellOfCategoryView(program: item)
                   Divider()
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
                     Divider()
                 }
                
            }
               
    }
        
    }
}


struct CellOfCategoryView : View {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    @State var program : Programs
    var body : some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8).foregroundColor(.white)
                
        VStack(spacing: 5){

            AsyncImage(url: URL(string: program.programimagetemplate )){ima in
                ima.resizable().frame(width: width-20, height: height * 0.25, alignment: .center).scaledToFill()
                   } placeholder: {
                         ProgressView()
                 }
                    

            Text(program.name ).font(.system(size: 20, weight: .bold, design: .default))
            Text(program.description )
                    Text("Categori : \(program.programcategory?.name ?? "")")

        }.foregroundColor(.black).padding(.horizontal, 10)
    }.shadow(radius: 4, y: 1).frame(width: width - 2, height: height * 0.40, alignment: .center).shadow(radius: 10)
}
}
