//
//  SignupView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-16.
//

import SwiftUI
import Firebase

struct RegisterView: View {
    
    let width = UIScreen.main.bounds.width
    let heigt = UIScreen.main.bounds.height
    
    @State private var userName = ""
    @State private var password = ""
    @State private var email = ""
    @State private var fullname = ""

    @EnvironmentObject var firebaseActions : FirebaseActions
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {

        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()

                VStack {
                    Image("sr").resizable().renderingMode(.template).scaledToFit().foregroundColor(.black).frame(width: width * 0.95, height: heigt * 0.2)
                    
                    Text("Register your account").font(.title)
                    
                    
                    VStack (spacing: 20) {
                        CustomTextField(text: $email, placeholder: Text("Email"), imagename: "envelope").padding().background(Color(.init(white: 1, alpha: 0.15))).cornerRadius(10).foregroundColor(.white).padding(.horizontal, 32)
            
                        CustomTextField(text: $userName, placeholder: Text("User Name"), imagename: "person").padding().background(Color(.init(white: 1, alpha: 0.15))).cornerRadius(10).foregroundColor(.white).padding(.horizontal, 32)
                        
                        CustomTextField(text: $fullname, placeholder: Text("Full Name"), imagename: "person").padding().background(Color(.init(white: 1, alpha: 0.15))).cornerRadius(10).foregroundColor(.white).padding(.horizontal, 32)
                        
                        CustomSecureField(text: $password, placeholder: Text("Password")).padding().background(Color(.init(white: 1, alpha: 0.15))).cornerRadius(10).foregroundColor(.white).padding(.horizontal, 32)
                }
                    
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                            }) {
                            Text("Cancel")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 170, height: 50)
                                .background(Color(red: 0.8, green: 0.6, blue: 1.2, opacity: 0.2))
                                .clipShape(Capsule())
                                
                        }
                        
                        
                        Button(action: {
                            let user = Users(userName: userName, fullname: fullname, email: email)
                          firebaseActions.register(user: user, password: password){ isResult in
                               if isResult {
                                  presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }) {
                            Text("Sign Up")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 170, height: 50)
                                .background(Color(red: 0.8, green: 0.6, blue: 1.2, opacity: 0.2))
                                .clipShape(Capsule())
                                
                        }
                    }.padding(.horizontal).padding()
                    Spacer()
                    
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Text("Already have an account?").font(.system(size: 14))
                        Text("Sign In").font(.system(size: 14, weight: .semibold))
                    }.foregroundColor(.white)
                    
                }
            }

    }
    
    

}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
