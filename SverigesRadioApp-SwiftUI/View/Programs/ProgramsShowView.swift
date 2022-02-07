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
    @State var searchText : String = ""

    
//    apiProgram.programs.filter({"\($0)".contains(searchText) })
    
    var program : [Programs] {
        return searchText.isEmpty ? apiProgram.programs : apiProgram.filteredPrograms(searchText)
    }
    
//    mutating var program  : [Programs] { return program1.sort {$0.id! < $1.id!} }

    var body: some View {
        
        SwiftUI.ScrollView {
                LazyVStack{
                    Text("Programs").font(.largeTitle).padding(.leading).padding(.trailing).background(Color.red).foregroundColor(Color.white).cornerRadius(14)

                    ForEach(program.sorted(by: { $0.id! > $1.id! }).prefix(isShowMore)) { (item) in

                                NavigationLink {
                                    ProgramsView(programs: item)
                                    } label: {
                                        ProgramsRowView(program: item)
                                    }
                        }.searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Search any programs...")
                    
                    
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
