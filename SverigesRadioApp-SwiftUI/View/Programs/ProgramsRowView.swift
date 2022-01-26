//
//  ProgramsRowView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-22.
//

import SwiftUI
import Firebase

struct ProgramsRowView: View {
    @State var programsUrl : String
    @State var programName : String
    @State var isShowing : Bool
    @State var programDescription : String
    @State var programResponsEditor : String
    @ObservedObject var progApiModel = ProgramsApi()
    @State var program : Programs

    @State var isFavoriteSaved : Bool
    
    let db = Firestore.firestore()
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    
    var body: some View {
        
        
        ZStack {
            RoundedRectangle(cornerRadius: 8).foregroundColor(.white)
                .shadow(radius: 4, y: 1).frame(width: width - 2, height: height * 0.13, alignment: .center)
            
            HStack(spacing: 2) {
                AsyncImage(url: URL(string: programsUrl)){ima in
                    ima.resizable().scaledToFill().frame(maxWidth: 100).padding(.leading, 2).frame(width: width * 0.3, height: height * 0.12).clipShape(RoundedRectangle(cornerRadius: 13))
                    
                } placeholder: {
                    ProgressView()
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack{
                        Text(programName).font(.system(size: 18)).padding(.top, 10)
              
                        Spacer()
                        LikeButtonView(program: $program)
//                        Button(action: {
//
//                            progApiModel.checkProgramHasBeenSaved(progFavori: program)
//
//
//                        }, label: {
//                            LikeButtonView(docId: program.id!).padding(.trailing, 15).padding(.top, 10)})
                        
                    }
                   
                    Text(programDescription.prefix(100)).font(.system(size: 13)).lineLimit(2).multilineTextAlignment(.leading).frame(minHeight : 50).padding(.trailing, 5)
                  
                    Text("Ansvårig Person : \(programResponsEditor)").font(.system(size: 10)).padding(.bottom, 10)
                }.frame(width: width * 0.7, height: height * 0.13).foregroundColor(.black).padding(.leading, 10)
            }.padding(.leading, 30).padding(.trailing, 20)
        }.padding([.trailing, .leading])
        
    }

}
        
//
//struct ProgramsRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgramsRowView().previewLayout(.sizeThatFits)
//    }
//}
