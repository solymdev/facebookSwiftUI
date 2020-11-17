//
//  LoginView.swift
//  FacebookSwiftUI
//
//  Created by solym on 25/08/20.
//  Copyright © 2020 solym. All rights reserved.
//

import SwiftUI
import AuthenticationServices
import FBSDKLoginKit

struct LoginView: View {

    @State var toAddData : Bool = false
    @State private var toInfo: Bool = false
    @Binding var loginOn : Bool
    @State private var userID : String = UserDefaults.standard.string(forKey: "userId") ?? ""
    @Environment(\.presentationMode) private var presentationMode
    
    func checkStatus(){
    NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
        
        if(AccessToken.isCurrentAccessTokenActive){
            loginOn = true
            self.presentationMode.wrappedValue.dismiss()
        }        }
    
    NotificationCenter.default.addObserver(forName: NSNotification.Name("dismiss"), object: nil, queue: OperationQueue.main) { (_) in
        loginOn = true
        self.presentationMode.wrappedValue.dismiss()
        print("dismiss")
        }
    }
    
    func checkAppleSignIn(){
        
        if !(userID.isEmpty){
            toAddData = true
        }
    }
    var body: some View{
        VStack{
              RoundedRectangle(cornerRadius: 20)
                          .fill(Color("card"))
                           .shadow(radius: 5)
                          .padding()
                .overlay(
                    VStack{
        Text("Login")
            .font(.largeTitle)
            .fontWeight(.bold)
                Spacer()
                  .padding(.leading,3) .padding(.trailing,36)
               .padding()
         .frame(height:100)
        loginbtFB()
            .frame(width:220,height:50)
            .padding()
            SignUpWithAppleView()
             .frame(width:221,height:50)
                })
        }.onAppear(){
            self.checkAppleSignIn()
            self.checkStatus()
        }
        .navigationBarItems(trailing:
                        Button("Acerca") {
                         self.toInfo = true
                        }).sheet(isPresented: $toInfo) {
                         InfoView()
                     }
    }
}
struct loginbtFB: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
    let loginButton = FBLoginButton()
    for const in loginButton.constraints{
        if const.firstAttribute == NSLayoutConstraint.Attribute.height && const.constant == 28{
            loginButton.removeConstraint(const)
          }
        }
    loginButton.permissions = ["public_profile", "email"]
        return loginButton
    }

    func updateUIView(_ uiViewController: UIView, context: Context) {
        
    }
}

    struct SignUpWithAppleView: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme
       func makeCoordinator() -> AppleSignUpCoordinator {
          return AppleSignUpCoordinator(self)
       }
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton    {
        var button : ASAuthorizationAppleIDButton
        if (colorScheme == .dark){
            button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn,
               authorizationButtonStyle: .white)
        }else{
            button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn,
            authorizationButtonStyle: .black)
        }

       button.cornerRadius = 10
       button.addTarget(context.coordinator, action: #selector(AppleSignUpCoordinator.didTapButton),for: .touchUpInside)
    return button
    }
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
    }

struct loginfb_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginOn: .constant(false))
    }
}


