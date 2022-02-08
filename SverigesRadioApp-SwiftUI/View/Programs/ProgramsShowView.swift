//
//  ProgramsShowView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-17.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
import Firebase

struct ProgramsShowView: View {
    @EnvironmentObject var apiProgram : ProgramsApi
    @State var isShowing = false
    @State var isShowMore = 20
    @State var searchProgramText : String = ""

    
    var program : [Programs] {
        return searchProgramText.isEmpty ? apiProgram.programs : apiProgram.filteredPrograms(searchProgramText)
    }
    

    var body: some View {
        
        SwiftUI.ScrollView {
                LazyVStack{
                    Text("Programs").font(.system(size: 20)).padding(.leading).padding(.trailing).background(Color.red).foregroundColor(Color.white).cornerRadius(14)

                    ForEach(program.sorted(by: { $0.id! > $1.id! }).prefix(isShowMore)) { (item) in

                                NavigationLink {
                                    ProgramsView(programs: item)
                                    } label: {
                                        ProgramsRowView(program: item, likeButtonShow: true)
                                    }
                    }.searchable(text: $searchProgramText, placement: .navigationBarDrawer, prompt: "Search details in programs...")
                    
                    
                     Button{
                        isShowMore += 10
                    } label: {
                        HStack{
                            Image(systemName: "arrow.down.circle.fill").padding(.trailing, 10)
                            Text("Show more").padding(.trailing, 10)
                        }.foregroundColor(Color.white).background(Color.red).cornerRadius(20)
                        
                    }
                    
                }
               
        }
     }

}
