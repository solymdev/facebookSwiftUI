//
//  ProfileView.swift
//  FacebookSwiftUI
//
//  Created by R L on 16/11/20.
//

import SwiftUI
import FBSDKLoginKit

struct ProfileView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @State var fbButton = false
    @State var appleButton = false
    
    func checkStatus(){
      NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
          if !(AccessToken.isCurrentAccessTokenActive){
            self.presentationMode.wrappedValue.dismiss()
          }
          }
        
        if(AccessToken.isCurrentAccessTokenActive){
            fbButton = true
            return
        }
        if (UserDefaults.standard.string(forKey: "appleLogin") != nil){
            appleButton = true
        }
      }
    
    func delete(){
        UserDefaults.standard.set("" as String, forKey: "appleLogin")
    }
    
    var body: some View {
        VStack{
        Text("Logged!")
            if self.fbButton{
            loginbtFB()
                  .frame(width:100,height:28)
                .padding()
            }
            if self.appleButton{
            Button(action: {
                            self.delete()
                            self.presentationMode.wrappedValue.dismiss()
                          }) {
                            Text("Cerrar Sesión")
                                .frame(width:120)
                          }
            .frame(width:200)
            .padding()
            .background(Color("mainButtons"))
            .foregroundColor(Color("foreground"))
                .cornerRadius(40)
            .padding(.bottom,4)
            }
        }.onAppear(){
            self.checkStatus()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
