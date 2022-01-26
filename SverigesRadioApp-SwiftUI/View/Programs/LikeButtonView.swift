//
//  LikeButtonView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-26.
//

import SwiftUI

struct LikeButtonView: View {
    @ObservedObject var programApi = ProgramsApi()
    @Binding var program : Programs
    var body: some View {
        ForEach(programApi.favoriInfoArray){item in
            Button(action: {
                if programApi.checkDocumentId(program: item) {
                    programApi.checkProgramHasBeenSaved(progFavori: item)
                } else {
                    programApi.deleteFavoriPrograms(progFavori: item)
                }
                
                
                
            }, label: {
                Image(systemName: programApi.checkDocumentId(program: item) ? "heart.fill" : "heart").resizable().scaledToFit().frame(width: 25, height: 25).foregroundColor(.red).padding(.trailing, 15).padding(.top, 10)})
        }
        
        
      }
}

struct LikeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Like Button View")
//        LikeButtonView(docId: 438, program: program).previewLayout(.sizeThatFits)
    }
}
