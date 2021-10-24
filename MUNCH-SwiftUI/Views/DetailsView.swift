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
        
        ScrollView() {
            VStack(alignment: .leading, spacing: 15) {
                
                VStack(alignment: .leading) {
                    // Title
                    Text(recipe.title)
                        .bold()
                        .font(.largeTitle)
                    // Ready in minutes
                        Text("Ready in: \(recipe.readyInMinutes) minutes")
                            .bold()
                            .font(.title3)
                    // Servings
                    Text("$\(String(format: "%.00f", recipe.pricePerServing)) per serving for \(recipe.servings) servings")
                        .bold()
                        .font(.title3)

                }.padding(.vertical, 15)
            
                // Image
                AsyncImage(url: URL(string: recipe.image != nil ? recipe.image as! String : "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg")!,
                           placeholder: { Text("Loading ...") },
                           image: { Image(uiImage: $0).resizable() })
                    .aspectRatio(contentMode: .fit)

                // Summary
                Text("\(recipe.summary.html2String)")
                    .bold()
                    .font(.subheadline)
                
                // Ingredients
                if recipe.extendedIngredients != [] {
                    Text("Ingredients:")
                        .bold()
                        .font(.title2)
                        .padding(.top, 15)
                    ForEach(recipe.extendedIngredients!, id: \.self) { ingredient in
                        Text("• \(ingredient.original)" as String)
                            .bold()
                            .font(.title3)
                    }
                }
                
                // Instructions
                Text("Instructions:")
                    .bold()
                    .font(.title2)
                    .padding(.top, 15)
                Text("\(recipe.instructions.html2String)")
                    .bold()
                    .font(.title3)

                // Other
            
            
            }.padding()
        }
    }
}

// Code from Leo Dabus: https://stackoverflow.com/questions/28124119/convert-html-to-plain-text-in-swift
extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
