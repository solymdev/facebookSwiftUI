//
//  InfoView.swift
//  FacebookSwiftUI
//
//  Created by R L on 02/09/20.
//  Copyright © 2020 R L. All rights reserved.
//

import SwiftUI

struct InfoView: View {

    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack{
            Spacer()
            Text("Designed by")
                .font(.body)
                .fontWeight(.light)
            Link("so_lym", destination: URL(string: "http://solym.me")!)
                .foregroundColor(Color("tintColor"))
                .font(.headline)
            Spacer()
        Button(action: {
                     self.presentationMode.wrappedValue.dismiss()
                  }) {
                    Text("Regresar")
                      .frame(width:200)
                  }.padding()
            .background(Color("mainButtons"))
            .foregroundColor(Color("foreground"))
                             .cornerRadius(40)
                  .padding()
        }
    }
}

struct InfoView_Previews: PreviewProvider {

    static var previews: some View {
        InfoView()
    }
}
