//
//  ProgramsRowView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-22.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ProgramsRowView: View {
    
    @EnvironmentObject var progApiModel : ProgramsApi
    @EnvironmentObject var userActions : FirebaseActions
    @State var program : Programs
    @State var likeButtonShow :Bool

    
    let db = Firestore.firestore()
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    
    var body: some View {
        
        
        ZStack {
            RoundedRectangle(cornerRadius: 8).foregroundColor(.white)
                .shadow(radius: 4, y: 1).frame(width: width - 2, height: height * 0.13, alignment: .center)
            
            HStack(spacing: 2) {
                
                AsyncImage(url: URL(string: program.programimagetemplate)){ima in
                    ima.resizable().scaledToFill().frame(maxWidth: 100).padding(.leading, 2).frame(width: width * 0.3, height: height * 0.12).clipShape(RoundedRectangle(cornerRadius: 13))

                } placeholder: {
                    ProgressView()
                }
                
//                WebImage(url: URL(string: program.programimagetemplate)).resizable().scaledToFill().frame(maxWidth: 100).padding(.leading, 2).frame(width: width * 0.3, height: height * 0.12).clipShape(RoundedRectangle(cornerRadius: 13))
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack{
                        Text(program.name).font(.system(size: 18)).padding(.top, 10)
              
                        Spacer()
                        if userActions.userSession != nil {
                            
                            if likeButtonShow { LikeButtonView(program: program) }
                        }
                      
                        
                        
                    }
                   
                    Text(program.description.prefix(100) ).font(.system(size: 13)).lineLimit(2).multilineTextAlignment(.leading).frame(minHeight : 50).padding(.trailing, 5)
                  
                    Text("Ansvårig Person : \(program.responsibleeditor ?? "unknown")").font(.system(size: 10)).padding(.bottom, 10)
                }.frame(width: width * 0.7, height: height * 0.13).foregroundColor(.black).padding(.leading, 10)
            }.padding(.leading, 30).padding(.trailing, 20)
        }.padding([.trailing, .leading])
        
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
            Image(systemName: progApiModel.checkDocumentId(program: program) ? "heart.fill" : "heart").resizable().scaledToFit().frame(width: 25, height: 25).foregroundColor(.red).padding(.trailing, 15).padding(.top, 10)
        }.onAppear {
        
            progApiModel.favoriProgramsListListener()
        }
    }
}


