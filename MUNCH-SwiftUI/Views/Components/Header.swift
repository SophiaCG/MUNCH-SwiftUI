//
//  Header.swift
//  MUNCH-SwiftUI
//
//  Created by SCG on 10/22/21.
//

import SwiftUI

struct Header: View {
    
    @EnvironmentObject var viewModel: LogInSignUpVM     // calls view model to sign out
    @Binding var heartTapped: Bool      // MUNCH! button is tapped or not
    
    var body: some View {
        HStack(alignment: .center) {
            
            // Sign Out button
            Button {
                viewModel.signOut()
            } label: {
                Text("Sign Out")
                    .bold()
                    .font(.title3)
                    .padding(.trailing, 40)

            }
            
            // MUNCH! button that displays recipe cards
            Button(action: {
                heartTapped = true
            }) {
                Text("MUNCH!")
                    .foregroundColor(heartTapped ? .green : .black)
                    .font(.title)
                    .bold()

            }

            // Bookmark button that displays recipe list
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
