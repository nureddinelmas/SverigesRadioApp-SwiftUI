//
//  MyPageView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-19.
//

import SwiftUI
import Firebase

struct MyPageView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button {
            do {
                try Auth.auth().signOut()
                presentationMode.wrappedValue.dismiss()
            } catch{
                print("Sign out error!")
            }
        } label: {
            Text("Sign Out")
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
