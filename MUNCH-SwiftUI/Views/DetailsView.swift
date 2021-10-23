//
//  DetailsView.swift
//  MUNCH-SwiftUI
//
//  Created by SCG on 10/22/21.
//

import SwiftUI

struct DetailsView: View {
    
    @State var recipe: Recipe
    
    var body: some View {
        
        Text(recipe.title).bold()
        
    }
}
