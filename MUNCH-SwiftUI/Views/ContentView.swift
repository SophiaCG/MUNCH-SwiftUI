//
//  ContentView.swift
//  MUNCH-SwiftUI
//
//  Created by SCG on 10/22/21.
//

import SwiftUI
import CoreData

//MARK: - Shows recipes cards (default) and recipes list
struct ContentView: View {

    @State var recipes = [Recipe]()
    @State var isPresented: Bool = false    // Shows modal sheet
    @State var heartTapped: Bool = false    // Shows recipes cards vs. recipes list

    var body: some View {
        
        Header(heartTapped: $heartTapped)
        Spacer()
        
        if heartTapped {
            
            // Cards of recipes
            ZStack {
                ForEach(recipes) { recipe in
                    CardView(recipe: recipe)
                }
            }
            .padding(8)
            .zIndex(1.0)
            .onAppear() {
                // API call to request random recipes
                ViewModel().getRecipes { (recipes) in
                    self.recipes = recipes.recipes
                    print("RECIPES: \(recipes)")
                }
            }
            
        } else {
            // List of bookmarked recipes
            RecipesList(isPresented: $isPresented)
        }
    }
}
