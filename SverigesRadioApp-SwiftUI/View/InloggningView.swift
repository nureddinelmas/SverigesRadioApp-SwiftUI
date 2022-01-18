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
                Text("Welcome to Login Form").font(.largeTitle)
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
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack{
                            Image(systemName: "arrowshape.turn.up.backward.circle.fill").frame(width: 10, height: 10, alignment: .trailing).padding(.leading)
                            Text("Back")
                        }
                    }.buttonStyle(ButtonView())
                    Spacer()
                    Divider()
                    Spacer()
                    Button {
    //                         SIGN IN
                        
                        firebaseActions.signIn(email: email, password: password)
                        if firebaseActions.isOkej {
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            print("Error")
                        }
                       
    //                    if result {
    //                        presentationMode.wrappedValue.dismiss()
    //                        isshowing = true
    //                        print("current id -\(String(describing: Auth.auth().currentUser?.uid))")
    //                    }
                        } label: {
                            HStack{
                                Text("Sign in")
                                Image(systemName: "arrowshape.turn.up.right.circle.fill").frame(width: 10, height: 10, alignment: .trailing).padding(.leading)
                            }
                        
                        }.buttonStyle(ButtonView())
                }

                    Spacer()
                Button {
                    
//                    Go to signup Sida
                    isshowing.toggle()
                } label: {
                    Text("Not member? Register")
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
