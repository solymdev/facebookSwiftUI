//
//  AppleSignUpCoordinator.swift
//  FacebookSwiftUI
//
//  Created by solym on 25/08/20.
//  Copyright © 2020 solym. All rights reserved.
//

import SwiftUI
import AuthenticationServices


class AppleSignUpCoordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    var parent: SignUpWithAppleView?
    init(_ parent: SignUpWithAppleView) {
      self.parent = parent
      super.init()
    }
    
    @Environment(\.presentationMode) private var presentationMode
    
    @objc func didTapButton() {

      let appleIDProvider = ASAuthorizationAppleIDProvider()
      let request = appleIDProvider.createRequest()
      request.requestedScopes = [.fullName, .email]

      let authorizationController = ASAuthorizationController(authorizationRequests: [request])
      authorizationController.presentationContextProvider = self
      authorizationController.delegate = self
      authorizationController.performRequests()
   }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    let vc = UIApplication.shared.windows.last?.rootViewController
    return (vc?.view.window!)!
   }

   func authorizationController(controller: ASAuthorizationController,didCompleteWithAuthorization authorization: ASAuthorization)
 {
   guard let credentials = authorization.credential as? ASAuthorizationAppleIDCredential else {
     print("credentials not found….")
     return
   }
    
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    appleIDProvider.getCredentialState(forUserID: credentials.user) { (credentialState: ASAuthorizationAppleIDProvider.CredentialState, error: Error?) in
        
      if let error = error {
        print("Error state:")
        print(error)
        /// Something went wrong check error state
        return
      }
      switch (credentialState) {
      case .authorized:
        ///User is authorized to continue using your app
            print("authorized")
           print("User:" + credentials.user)
           let defaults = UserDefaults.standard
           let name = "\(credentials.fullName?.givenName ?? "Already")"
           let familyname = "\(credentials.fullName?.familyName ?? "Registered")"
           let fullname = name + " " + familyname
           let email = credentials.email ?? "hided@hotmail.com"
           print("Name:" + fullname)
           print("Email:" + email)
           defaults.set(fullname, forKey: "name")
           defaults.set(credentials.user, forKey: "idUser")
           defaults.set(email, forKey: "email")
           print("Se guardo data apple login.")
           defaults.set("yes", forKey: "appleLogin")
        NotificationCenter.default.post(name: NSNotification.Name("dismiss"), object: nil)
        
        break
      case .revoked:
        ///User has revoked access to your app
        print("access revoked")
        break
      case .notFound:
        ///User is not found, meaning that the user never signed in through Apple ID
        print("not found")
        break
      default: break
      }        
    }
 }

  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
   print("Error In Credential")
  }
}

struct AppleSignUpCordinator_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
