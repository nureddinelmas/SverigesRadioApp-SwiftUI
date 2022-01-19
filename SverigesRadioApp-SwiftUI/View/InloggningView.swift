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
    @State private var isSingUpshowing = false
    @State private var isPopupShowing = false
    @State private var isLoggInOkey = false
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var firebaseActions = FirebaseActions()
    
    var body: some View {
        ZStack {
            VStack(alignment: .center){
                Form {
                    Text("Welcome to Login Form").font(.largeTitle)
                    Spacer()
                    HStack {
                        Text("Email : ")
                        TextField(text: $email, prompt: Text("Required")) {
                            Text("User Name ->")
                        }.disableAutocorrection(true).textFieldStyle(.roundedBorder).shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    }
                    
                    HStack{
                        Text("Password")
                        TextField(text: $password, prompt: Text("Required")) {
                            
                        }.disableAutocorrection(true).textFieldStyle(.roundedBorder).shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    }
                    HStack{
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            HStack{
                                Image(systemName: "arrowshape.turn.up.backward.circle.fill").frame(width: 10, height: 10, alignment: .trailing).padding(.leading)
                                Text("Back").padding(.horizontal)
                            }
                        }.buttonStyle(ButtonView())
                        Spacer()
                        Divider()
                        Spacer()
                        Button {
        //                         SIGN IN
                            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                                guard let _ = result, error == nil else {return}
                               
                                print("Current User \(Auth.auth().currentUser?.uid)")
                                isLoggInOkey = true
                            }
                            isPopupShowing = true
                            
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
                        isSingUpshowing.toggle()
                    } label: {
                        Text("Not member? Register")
                    }.sheet(isPresented: $isSingUpshowing) {
                        SignupView()
                    }
                }
            }
            
            if $isPopupShowing.wrappedValue {
                ZStack{
                    Color.black.opacity(0.7).edgesIgnoringSafeArea(.vertical)
//                    when it opens the background will be dark
                    
                    VStack(spacing: 20){
                        Text(self.isLoggInOkey ? "Successfully! " : "Unsuccessfully").bold().padding().frame(maxWidth: .infinity).background(Color.orange).foregroundColor(.white)
                        Spacer()
                        
                        Text(self.isLoggInOkey ? "Inloggning is succesfully" : "Inloggning is NOT succesfully").foregroundColor(self.isLoggInOkey ? .green : .red).bold()
                        Spacer()
                        Button {
                            if isLoggInOkey{
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                isPopupShowing = false
                            }
                          
                        } label: {
                            if isLoggInOkey{
                                Text("Go To Main Sida")
                            } else {
                                Text("Close and enter again!")
                            }
                            
                        }.padding(.bottom, 20)
                    }.frame(width: 300, height: 300, alignment: .center).background(Color.white).cornerRadius(20).shadow(radius: 20)
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
