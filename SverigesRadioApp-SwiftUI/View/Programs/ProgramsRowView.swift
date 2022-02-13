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

    @State var program : Programs

 
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    

    
    
    var body: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 8).foregroundColor(.white)
                .shadow(radius: 4, y: 1).frame(width: width - 2, height: height * 0.15, alignment: .center)
            
            HStack(alignment: .center, spacing: 2) {
                
                AsyncImage(url: URL(string: program.programimagetemplate)){ima in
                    ima.resizable().scaledToFill().frame(maxWidth: 100).padding(.leading, 2).clipShape(RoundedRectangle(cornerRadius: 13)).frame(width: width * 0.3, height: height * 0.14)
                } placeholder: {
                    ProgressView()
                }
                VStack(alignment: .leading, spacing: 4) {
  
                    Text(program.name).font(.system(size: 18)).lineLimit(1)
                    Text(program.description).font(.system(size: 13)).multilineTextAlignment(.leading).frame(width: width * 0.68, height: height * 0.07, alignment: .leading)
                  
                   Spacer()
                    Text("Ansvårig Person : \(program.responsibleeditor ?? "unknown")").font(.system(size: 10)).padding(.bottom, 10)

                }.frame(width: width * 0.68).foregroundColor(.black)
                Spacer()
            }.frame(width: width * 0.97, height: height * 0.14).padding(.horizontal, 10)
        }
        
    }

}















