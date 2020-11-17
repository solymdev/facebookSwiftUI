//
//  ContentView.swift
//  FacebookSwiftUI
//
//  Created by solym on 25/08/20.
//  Copyright © 2020 solym. All rights reserved.
//

import SwiftUI
import FBSDKLoginKit

struct ContentView: View {
    
    @State private var logoAnimation : Bool = false
    @State private var toMenu: Int? = 0
    @State private var toLogin: Bool = false
    @State private var toProfile: Bool = false
    @State private var toMap: Int? = 0
    @State var logged : Bool = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    func checkStatus(){
    NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
        if(AccessToken.isCurrentAccessTokenActive){
            print("LOGGED")
            self.logged = true
        }else{
            print("NOT LOGGED")
            self.logged = false
        }
        }
        
        if(AccessToken.isCurrentAccessTokenActive){
            print("LOGGED")
            self.logged = true
        }else{
            print("NOT LOGGED")
            self.logged = false
        }
    }
    
    var body: some View {
        NavigationView{
        VStack{
            Text("Facebook Login")
                .fontWeight(.thin)
                .font(.largeTitle)
                .padding(.bottom,0)
            Text("SwiftUI")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom,32)

            Button(action:{
                if(self.logged || !(UserDefaults.standard.string(forKey: "email")?.isEmpty ?? true)){
                    print("toProfile")
                    self.toProfile = true
                }else{
                    print("toLogin")
                    self.toLogin.toggle()
                }
                       }){
                HStack{
                           Text("Acceder")
                            .foregroundColor(.black)
                            .frame(width:120)
                }
                .sheet(isPresented: $toLogin) {
                    LoginView(loginOn: $toProfile)
             }
                        .frame(width:200)
                       }
                       .padding()
                       .background(Color("mainButtons"))
            .foregroundColor(Color("foreground"))
                           .cornerRadius(40)
            .padding(.bottom,4)
            
            NavigationLink(destination: ProfileView(), isActive: $toProfile) {
                           EmptyView()
                                   }
            Spacer()
                .frame(height:40)
        }.onAppear(){
            self.checkStatus()
        }
    }.accentColor(.black)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        }

}


