//
//  deneme.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-02-07.
//

import SwiftUI
import Firebase

struct InloggningView: View {
    let width = UIScreen.main.bounds.width
    let heigt = UIScreen.main.bounds.height
    
    @State var email : String = ""
    @State var password : String = ""
    
    
    @State private var isSingUpshowing = false
    @State private var isPopupShowing = false
    @State private var isLoggInOkey = false
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var firebaseActions : FirebaseActions
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            VStack {
                Image("sr").resizable().renderingMode(.template).scaledToFit().foregroundColor(.black).frame(width: width * 0.95, height: heigt * 0.3)
                
                VStack (spacing: 20) {
                    CustomTextField(text: $email, placeholder: Text("Email"), imagename: "envelope").padding().background(Color(.init(white: 1, alpha: 0.15))).cornerRadius(10).foregroundColor(.white).padding(.horizontal, 23)
                    
                    CustomSecureField(text: $password, placeholder: Text("Password")).padding().background(Color(.init(white: 1, alpha: 0.15))).cornerRadius(10).foregroundColor(.white).padding(.horizontal, 23)
                }
                
                HStack{
                    Spacer()
                    Button(action: {}) {
                        Text("Forgot Password?")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.top)
                            .padding(.trailing, 23)
                    }.padding(.bottom, 30)
                }
                HStack(){
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
                        firebaseActions.login(withEmail: email, password: password) { islog in
                            if islog {
                                isLoggInOkey = true
                                isPopupShowing = true
                            }
                            
                        }
                    }) {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 170, height: 50)
                            .background(Color(red: 0.8, green: 0.6, blue: 1.2, opacity: 0.2))
                            .clipShape(Capsule())
                            
                    }
                }.padding(.horizontal)
               
                Spacer()
                
                NavigationLink(destination: {
                    RegisterView()
                }) {
                    Text("Dont have an account?")
                        .font(.system(size: 14))
                        
                    Text("Sign Up").font(.system(size: 14, weight: .semibold))
                }.foregroundColor(.white)
            }.padding(.bottom, 16)

        
        
        if $isPopupShowing.wrappedValue {
            ZStack{
                Color.black.opacity(0.7).edgesIgnoringSafeArea(.vertical)
//                    when it opens the background will be dark
                
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()

                    VStack(spacing: 10){
                        Text(self.isLoggInOkey ? "Successfully! " : "Unsuccessfully").bold().padding().frame(maxWidth: .infinity).foregroundColor(.white)
                        Spacer()
                        
                        Text(self.isLoggInOkey ? "Inloggning is succesfully" : "Inloggning is NOT succesfully").foregroundColor(self.isLoggInOkey ? .white : .red).bold()
                        Spacer()
                        Button {
                            if isLoggInOkey {
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
                            
                        }.padding(.bottom, 20).foregroundColor(.white)
                    }
                }.frame(width: 300, height: 300, alignment: .center).cornerRadius(20).shadow(radius: 20)
            }
        }
    }
    }
}

struct InloggningView_Previews: PreviewProvider {
    static var previews: some View {
        InloggningView(email: "", password: "")
    }
}












//
//
//
//
//
//
//
//
//
//
////
////  InloggningView.swift
////  SverigesRadioApp-SwiftUI
////
////  Created by Nureddin Elmas on 2022-01-16.
////
//
//import SwiftUI
//import Firebase
//
//struct InloggningView: View {
//    @State var email = ""
//    @State var password = ""
//    @State private var isSingUpshowing = false
//    @State private var isPopupShowing = false
//    @State private var isLoggInOkey = false
//    @Environment(\.presentationMode) private var presentationMode
//    @EnvironmentObject var firebaseActions : FirebaseActions
//
//    var body: some View {
//        ZStack {
//            VStack(alignment: .center){
//                Form {
//                    Text("Welcome to Login Form").font(.largeTitle)
//                    Spacer()
//                    HStack {
//                        Text("Email : ")
//                        TextField(text: $email, prompt: Text("Required")) {
//                            Text("User Name ->")
//                        }.disableAutocorrection(true).textFieldStyle(.roundedBorder).shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
//                    }
//
//                    HStack{
//                        Text("Password :")
//                        TextField(text: $password, prompt: Text("Required")) {
//
//                        }.disableAutocorrection(true).textFieldStyle(.roundedBorder).shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
//                    }
//                    HStack{
//                        Button {
//                            presentationMode.wrappedValue.dismiss()
//                        } label: {
//                            HStack{
//                                Image(systemName: "arrowshape.turn.up.backward.circle.fill").frame(width: 10, height: 10, alignment: .trailing).padding(.leading)
//                                Text("Back").padding(.horizontal)
//                            }
//                        }.buttonStyle(ButtonView())
//                        Spacer()
//                        Divider()
//                        Spacer()
//                        Button {
//        //                         SIGN IN
//                            firebaseActions.login(withEmail: email, password: password) { islog in
//                                if islog {
//                                    isLoggInOkey = true
//                                    isPopupShowing = true
//                                }
//
//                            }
//
//
//
//                            } label: {
//                                HStack{
//                                    Text("Sign in")
//                                    Image(systemName: "arrowshape.turn.up.right.circle.fill").frame(width: 10, height: 10, alignment: .trailing).padding(.leading)
//                                }
//
//                            }.buttonStyle(ButtonView())
//                    }
//
//                        Spacer()
//                    Button {
//
//    //                    Go to signup Sida
//                        isSingUpshowing.toggle()
//                    } label: {
//                        Text("Not member? Register")
//                    }.sheet(isPresented: $isSingUpshowing) {
//                        RegisterView()
//                    }
//                }
//            }
//
//            if $isPopupShowing.wrappedValue {
//                ZStack{
//                    Color.black.opacity(0.7).edgesIgnoringSafeArea(.vertical)
////                    when it opens the background will be dark
//
//                    VStack(spacing: 10){
//                        Text(self.isLoggInOkey ? "Successfully! " : "Unsuccessfully").bold().padding().frame(maxWidth: .infinity).background(Color.orange).foregroundColor(.white)
//                        Spacer()
//
//                        Text(self.isLoggInOkey ? "Inloggning is succesfully" : "Inloggning is NOT succesfully").foregroundColor(self.isLoggInOkey ? .green : .red).bold()
//                        Spacer()
//                        Button {
//                            if isLoggInOkey {
//                                presentationMode.wrappedValue.dismiss()
//                            } else {
//                                isPopupShowing = false
//                            }
//
//                        } label: {
//                            if isLoggInOkey{
//                                Text("Go To Main Sida")
//                            } else {
//                                Text("Close and enter again!")
//                            }
//
//                        }.padding(.bottom, 20)
//                    }.frame(width: 300, height: 300, alignment: .center).background(Color.white).cornerRadius(20).shadow(radius: 20)
//                }
//            }
//        }
//    }
//}
//
////struct InloggningView_Previews: PreviewProvider {
////    static var previews: some View {
////        InloggningView()
////    }
////}
