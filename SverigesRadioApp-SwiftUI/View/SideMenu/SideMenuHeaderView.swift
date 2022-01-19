//
//  SideMenuHeaderView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-18.
//

import SwiftUI
import Firebase

struct SideMenuHeaderView: View {
    @Binding var isShowing: Bool
    @State var userName : String = ""
    @State var user:Users?
    @ObservedObject var getFirebase = FirebaseActions()
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button {
                withAnimation(.spring()){
                    isShowing.toggle()
                }
                
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 32, height: 32)
                    .foregroundColor(.white)
                    .padding()
            }

            VStack(alignment: .leading){
                Text("Sveriges Radio")
                    .font(.system(size: 24, weight: .semibold)).padding(.bottom, 10)
                Text(getUser()).font(.system(size: 14))
                HStack(spacing: 12){
                    Spacer()
                }
                  Spacer()
            }.padding()
        }
    }
    
    func getUser() -> String{
        var nameSurname : String?
        if Auth.auth().currentUser?.uid != nil {
            for i in getFirebase.users {
                nameSurname =  "\(i.name) \(i.surname)"
    
            }
        } else {
            nameSurname = "Anonymous"
        }
      
        return nameSurname ?? "Sign In"
    }
}

struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuHeaderView(isShowing: .constant(true))
    }
}
