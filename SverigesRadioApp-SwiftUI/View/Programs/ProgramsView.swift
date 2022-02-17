//
//  ProgramsView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-15.
//

import SwiftUI

struct ProgramsView: View {
    @State var program:Programs
    @State var isShareSheetShowing = false
    
    
    var widthControl: CGFloat { return UIScreen.main.bounds.width * 0.07 }
    var heigthControl: CGFloat { return UIScreen.main.bounds.width * 0.05  }
    var shareMessage : String { return "Hej, Kära vän! Jag rekomenderar den här program som heter \(program.name). För att lyssna klicka den här länken -> \(String(describing: program.programurl!)) 😀 Hälsningar. " }
    
    
    var body: some View {
        UrlWebView(urlToDisplay: program.programurl ?? "")
            .navigationTitle(program.name)
            .navigationBarItems(trailing: details)
    }

    var details : some View {
        Menu {
            LikeButtonView(program: program)
            Button {
                isShareSheetShowing = true
                print("pressed sheet")
            } label: {
                HStack(spacing : 4) {
                    Image(systemName: "square.and.arrow.up")
                    Text("Share")}
                }
        } label: {
                Image(systemName: "ellipsis.circle").resizable().scaledToFit().font(.largeTitle).frame(width: widthControl, height: heigthControl).foregroundColor(.red)
           
        }.sheet(isPresented: $isShareSheetShowing, onDismiss: {isShareSheetShowing = false}, content: {ActivityViewController(itemsToShare: [shareMessage])})
        
        }
    }

struct LikeButtonView : View {
    @EnvironmentObject var progApiModel : ProgramsApi
    @State var program : Programs
    var body: some View {
        
        Button(action: {
           
            
                if progApiModel.checkDocumentId(program: program) {
                    
                    progApiModel.deleteFavoriPrograms(progFavori: program)
                    progApiModel.favoriInfoArray.removeAll()
                    progApiModel.favoriProgramsListListener()
                  
                } else {
                   
                    progApiModel.checkProgramHasBeenSaved(progFavori: program)
                }
         
        }) {
             HStack(spacing : 4 ){
              Text(progApiModel.checkDocumentId(program: program) ? "Delete" : "Add Favorite")
              Image(systemName: progApiModel.checkDocumentId(program: program) ? "trash" : "heart")
             }.foregroundColor(.red)

        }.onAppear {
        
            progApiModel.favoriProgramsListListener()
        }
    }
}
