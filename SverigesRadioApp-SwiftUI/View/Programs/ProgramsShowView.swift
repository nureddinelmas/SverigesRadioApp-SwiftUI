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
//        return searchProgramText.isEmpty ? apiProgram.programs : apiProgram.filteredPrograms(searchProgramText)
        return apiProgram.programs.filter({ "\($0)".contains(searchProgramText) || searchProgramText.isEmpty })
    }
    

    var body: some View {
        
        SwiftUI.ScrollView {
                LazyVStack{
                    

                    ForEach(program.sorted(by: { $0.id! > $1.id! }).prefix(isShowMore)) { (item) in

                                NavigationLink {
                                    ProgramsView(program: item)
                                    } label: {
                                        ProgramsRowView(program: item, isDeleteShowing: false)
                                    }
                    }.searchable(text: $searchProgramText, placement: .navigationBarDrawer, prompt: "Search details in programs...")
                        .navigationTitle("Programs")
                    
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
