//
//  Card.swift
//  MUNCH-SwiftUI
//
//  Created by SCG on 10/22/21.
//

import UIKit
import SwiftUI

//MARK: - DATA
struct Card: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let age: Int
    let bio: String
    /// Card x position
    var x: CGFloat = 0.0
    /// Card y position
    var y: CGFloat = 0.0
    /// Card rotation angle
    var degree: Double = 0.0
    
    static var data: [Card] {
        [
            Card(name: "Rosie", imageName: "person", age: 21, bio: "Insta - roooox 💋"),
            Card(name: "Betty", imageName: "person", age: 23, bio: "Like exercising, going out, pub, working 🍻"),
            Card(name: "Abigail", imageName: "person", age: 26, bio: "hi, let's be friends"),
            Card(name: "Zoé", imageName: "person", age: 20, bio: "Law grad"),
            Card(name: "Tilly", imageName: "person", age: 21, bio: "Follow me on IG"),
            Card(name: "Penny", imageName: "person", age: 24, bio: "J'aime la vie et le vin 🍷"),
        ]
    }
    
}
