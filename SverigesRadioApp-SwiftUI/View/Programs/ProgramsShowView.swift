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
    @ObservedObject var apiProgram = ProgramsApi()
    @State var isShowing = false
    @State var isShowMore = 70
    @State var searchText = ""
    var db = Firestore.firestore()
    var body: some View {
        
        SwiftUI.ScrollView {
                LazyVStack{
                    Text("Programs").font(.largeTitle).padding(.leading).padding(.trailing).background(Color.red).foregroundColor(Color.white).cornerRadius(14)
                    
                    if searchText != "" {
                       
                            ForEach(apiProgram.programs.filter({"\($0)".contains(searchText) || searchText.isEmpty})){ item in
                                NavigationLink {
                                    ProgramsView(programs: item)
                                } label: {
                                    ProgramsRowView(programsUrl: item.programimagetemplate ?? "", programName: item.name ?? "", isShowing: true, programDescription: item.description ?? "", programResponsEditor: item.responsibleeditor ?? "", program: item, isFavoriteSaved: false)
                                }
                            
                            }.searchable(text: $searchText)
                   
                       
                    } else {
                        ForEach(apiProgram.programs.indices, id: \.self){index in
                            if index > 50 && index < isShowMore {
                                
                                    NavigationLink {
                                        ProgramsView(programs: apiProgram.programs[index])
                                    } label: {

                                                
                                                ProgramsRowView(programsUrl: apiProgram.programs[index].programimagetemplate ?? "", programName: apiProgram.programs[index].name ?? "", isShowing: true, programDescription: apiProgram.programs[index].description ?? "", programResponsEditor: apiProgram.programs[index].responsibleeditor ?? "", program: apiProgram.programs[index], isFavoriteSaved: true)
                                    }

                            }
                        }.searchable(text: $searchText)
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
    
    
    func check(docID: Int) -> Bool {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return false}
        var sonuc = false
        db.collection("Users").document(currentUserId).collection("ProgramsFavorite").whereField("id", isEqualTo: docID).getDocuments { snapshot, error in
            if snapshot?.documents.isEmpty != true {
                sonuc = true
        }
           
    }
        print("sonuc \(sonuc)")
        return sonuc
}

}
struct ProgramsShowView_Previews: PreviewProvider {
    static var previews: some View {
        ProgramsShowView()
    }
}
