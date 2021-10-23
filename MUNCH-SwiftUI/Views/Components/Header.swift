//
//  Header.swift
//  MUNCH-SwiftUI
//
//  Created by SCG on 10/22/21.
//

import SwiftUI

struct Header: View {
    
    @Binding var heartTapped: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                heartTapped = true
            }) {
                Image(systemName: heartTapped ? "heart.fill" : "heart")
                    .resizable().aspectRatio(contentMode: .fit).frame(height:30)
                    .foregroundColor(heartTapped ? .red : .black)
            }
            
            Spacer()
            
            Text("MUNCH!")
                .font(.title)
                .bold()
            
            Spacer()

            Button(action: {
                heartTapped = false
            }) {
                Image(systemName: heartTapped ? "bookmark" : "bookmark.fill")
                    .resizable().aspectRatio(contentMode: .fit).frame(height:30)
                    .foregroundColor(heartTapped ? .black : .green)
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 15)
    }
}
