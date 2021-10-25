//
//  ViewModel.swift
//  MUNCH-SwiftUI
//
//  Created by SCG on 10/22/21.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var recipes = [Recipe]()     // Holds multiple recipes for cards
    @Published var details = Optional<Recipe>.none      // Holds details for one recipe in list
    let apiKey = "d2d9b7ba70d64ecd85ab8eecf9cfd8fc"     // API key can be given here: https://spoonacular.com/food-api
    
//MARK: - Retrieves multiple recipes that will be displayed to the user in a deck of cards
    func getRecipes(completion:@escaping (Recipes) -> ()) {
        
        guard let url = URL(string: "https://api.spoonacular.com/recipes/random?number=3&apiKey=\(apiKey)") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard data != nil else {
                print("ERROR: \(String(describing: error))")
                return
            }
            
            do {
                let results = try JSONDecoder().decode(Recipes.self, from: data!)
//                print("RESULTS: \(results)")
                
                DispatchQueue.main.async {
                    self.recipes = results.recipes

                    completion(results)
                }
            } catch DecodingError.dataCorrupted(let context) {
                print(context)
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.valueNotFound(let value, let context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.typeMismatch(let type, let context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("Error: ", error)
            }

        }
        task.resume()
    }
    
//MARK: - Retrieves details of a recipe that the user has bookmarked
    func getDetails(for id: String, completion:@escaping (Recipe) -> ()) {
        
        guard let url = URL(string: "https://api.spoonacular.com/recipes/\(id)/information?apiKey=\(apiKey)") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard data != nil else {
                print("ERROR: \(String(describing: error))")
                return
            }
            
            do {
                let results = try JSONDecoder().decode(Recipe.self, from: data!)
//                print("RESULTS: \(results)")
                
                DispatchQueue.main.async {
                    self.details = results

                    completion(results)
                }
            } catch DecodingError.dataCorrupted(let context) {
                print(context)
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.valueNotFound(let value, let context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.typeMismatch(let type, let context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("Error: ", error)
            }

        }
        task.resume()

    }

}
