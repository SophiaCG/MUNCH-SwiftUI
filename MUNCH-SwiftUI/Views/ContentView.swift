//
//  ContentView.swift
//  MUNCH-SwiftUI
//
//  Created by SCG on 10/22/21.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State var recipes = [Recipe]()
    @State var isPresented: Bool = false
    @State var heartTapped: Bool = true

    var body: some View {
        
        Header(heartTapped: $heartTapped)
        Spacer()
        
        if heartTapped {

            ZStack {
                ForEach(recipes) { recipe in
                    CardView(recipe: recipe)
                }
            }
            .padding(8)
            .zIndex(1.0)
            .onAppear() {
                ViewModel().getRecipes { (recipes) in
                    self.recipes = recipes.recipes
                    print("RECIPES: \(recipes)")
                }
            }
            
        } else {
            RecipesList(isPresented: $isPresented)
        }
    }
}
