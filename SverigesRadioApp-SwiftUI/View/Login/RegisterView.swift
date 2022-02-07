//
//  SignupView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-16.
//

import SwiftUI
import Firebase

struct RegisterView: View {
    @State private var userName = ""
    @State private var password = ""
    @State private var email = ""
    @State private var name = ""
    @State private var surname = ""
    @EnvironmentObject var firebaseActions : FirebaseActions
    @Environment(\.presentationMode) private var presentationMode
    var db = Firestore.firestore()
    
    var body: some View {

        Form {
            Spacer()
            Text("Welcome to Sign up Page ").font(.largeTitle)
            Spacer()
            HStack {
                Text("User Name : ")
                TextField(text: $userName, prompt: Text("Required")) {
                    Text("User Name ->")
                }.disableAutocorrection(true).textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Text("Email : ")
                TextField(text: $email, prompt: Text("Required")) {
                    Text("User Name ->")
                }.disableAutocorrection(true).textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Text("Password : ")
                TextField(text: $password, prompt: Text("Required")) {
                    Text("User Name ->")
                }.disableAutocorrection(true).textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Text("Name : ")
                TextField(text: $name, prompt: Text("Required")) {
                    Text("User Name ->")
                }.disableAutocorrection(true).textFieldStyle(.roundedBorder)
            }
            
            
            HStack {
                Text("Surname : ")
                TextField(text: $surname, prompt: Text("Required")) {
                    Text("User Name ->")
                }.disableAutocorrection(true).textFieldStyle(.roundedBorder)
            }
           
            Spacer()
            Button {
//                         Sign in
                let user = Users(userName: userName, name: name, surname: surname, email: email)
                firebaseActions.register(user: user, password: password){ isResult in
                    if isResult {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                } label: {
                    Text("Sign up")
                }.buttonStyle(ButtonView())
            
           

            
        }
    }
    
    

}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
