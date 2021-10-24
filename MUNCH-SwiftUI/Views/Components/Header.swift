//
//  Header.swift
//  MUNCH-SwiftUI
//
//  Created by SCG on 10/22/21.
//

import SwiftUI

struct Header: View {
    
    @EnvironmentObject var viewModel: LogInSignUpVM
    @Binding var heartTapped: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            
            Button {
                viewModel.signOut()
            } label: {
                Text("Sign Out")
                    .bold()
                    .font(.title3)
                    .padding(.trailing, 40)

            }
            
            Button(action: {
                heartTapped = true
            }) {
                Text("MUNCH!")
                    .foregroundColor(heartTapped ? .green : .black)
                    .font(.title)
                    .bold()

            }

            Button(action: {
                heartTapped = false
            }) {
                Image(systemName: heartTapped ? "bookmark" : "bookmark.fill")
                    .resizable().aspectRatio(contentMode: .fit).frame(height:30)
                    .foregroundColor(heartTapped ? .black : .green)
                    .padding(.leading, 80)

            }
        }
        .padding(.vertical, 15)
    }
}
