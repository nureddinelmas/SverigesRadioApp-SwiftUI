//
//  InloggningView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-16.
//

import SwiftUI
import Firebase

struct InloggningView: View {
    @State var email = ""
    @State var password = ""
    @State private var isshowing = false
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var firebaseActions = FirebaseActions()
    var body: some View {
        Spacer()
        VStack(alignment: .center){
            
            
            Form {
                Text("Welcome to Login Sida").font(.largeTitle)
                Spacer()
                HStack {
                    Text("Email : ")
                    TextField(text: $email, prompt: Text("Required")) {
                        Text("User Name ->")
                    }.disableAutocorrection(true).textFieldStyle(.roundedBorder)
                }
                
                HStack{
                    Text("Password")
                    TextField(text: $password, prompt: Text("Required")) {
                        
                    }.disableAutocorrection(true).textFieldStyle(.roundedBorder)
                }
                
                Button {
//                         Sign in
                    let result = firebaseActions.signIn(email: email, password: password)
                    if result {
                        presentationMode.wrappedValue.dismiss()
                        isshowing = true
                        print("current id -\(String(describing: Auth.auth().currentUser?.uid))")
                    }
                    } label: {
                        Text("Sign in")
                    }.buttonStyle(ButtonView())
                    Spacer()
                Button {
                    
//                    Go to signup Sida
                    isshowing.toggle()
                } label: {
                    Text("Become a member?")
                }.sheet(isPresented: $isshowing) {
                    SignupView()
                }


            }
            
                          
            
        }
    }
}

struct InloggningView_Previews: PreviewProvider {
    static var previews: some View {
        InloggningView()
    }
}
