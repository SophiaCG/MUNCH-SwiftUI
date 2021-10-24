//
//  ViewModel.swift
//  MUNCH-SwiftUI
//
//  Created by SCG on 10/22/21.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var recipes = [Recipe]()
    @Published var details = Optional<Recipe>.none
    let apiKey = "API-KEY-HERE"
    
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
//                    self.recipes.compactMap { $0 }

                    print("\n\nTESTINGIGNEINIG: \(type(of: self.recipes[0]))")
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
                print("RESULTS: \(results)")
                
                DispatchQueue.main.async {
                    self.details = results

                    print("\n\nTESTINGIGNEINIG: \(String(describing: self.details))")
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
