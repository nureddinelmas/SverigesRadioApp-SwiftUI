//
//  ProgramsShowInMainView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-02-08.
//

import SwiftUI

struct ProgramsShowInMainView: View {
        @EnvironmentObject var apiProgram : ProgramsApi
        @State var isShowing = false
        @State var isShowMore = 20
        @Binding var searchText : String

        
        var program : [Programs] {
//            return searchText.isEmpty ? apiProgram.programs : apiProgram.filteredPrograms(searchText)
            return apiProgram.programs.filter({ "\($0)".contains(searchText) || searchText.isEmpty })
        }
        

        var body: some View {
            
            SwiftUI.ScrollView {
                    LazyVStack{
                        Text("Programs").font(.system(size: 20)).padding(.leading).padding(.trailing).background(Color.red).foregroundColor(Color.white).cornerRadius(14)

                        ForEach(program.sorted(by: { $0.id! > $1.id! }).prefix(isShowMore)) { (item) in

                                    NavigationLink {
                                        ProgramsView(program: item)
                                        } label: {
                                            ProgramsRowView(program: item, isDeleteShowing: false)
                                        }
                        }
                        
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
