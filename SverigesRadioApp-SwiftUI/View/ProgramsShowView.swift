//
//  ProgramsShowView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-17.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct ProgramsShowView: View {
    @ObservedObject var apiProgram = ProgramsApi()
    @State var isShowing = false
    var body: some View {
        SwiftUI.ScrollView {
                VStack{
                    Text("Programs").font(.largeTitle).padding(.leading).padding(.trailing).background(Color.red).foregroundColor(Color.white).cornerRadius(14)
//                    ForEach(apiProgram.programs.indices, id: \.self){index in
//                        if index > 50 && index < 100 {
//                            Text(apiProgram.programs[index].name!)
//
//                        }
//                    }
                    ForEach(apiProgram.programs.indices, id: \.self){index in
                        if index > 50 && index < 100 {
                                       NavigationLink {
                                           ProgramsView(programs: apiProgram.programs[index])
                                       } label: {
                                           VStack(alignment: .center){
                                               WebImage(url: URL(string: apiProgram.programs[index].programimagetemplate ?? "")).resizable().scaledToFit()
                                               }
                                       }
                                Text(apiProgram.programs[index].name ?? "").font(.system(size: 20, weight: .bold, design: .default))
                            Text(isShowing ? ((apiProgram.programs[index].description?.prefix(550))!) + "...less" : ((apiProgram.programs[index].description?.prefix(50))!) + "...more").font(.system(size: 15, weight: .bold, design: .default)).onTapGesture {
                                isShowing.toggle()
                        }
                               Text("Ansvårig Person : \(apiProgram.programs[index].responsibleeditor ?? "")")
                            Divider()
                               }
                    }
                }
    }
}
}

struct ProgramsShowView_Previews: PreviewProvider {
    static var previews: some View {
        ProgramsShowView()
    }
}
