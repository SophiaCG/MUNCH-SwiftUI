//
//  Model.swift
//  MUNCH-SwiftUI
//
//  Created by SCG on 10/22/21.
//

import Foundation
import SwiftUI
import Combine


struct Recipes: Codable {
    var recipes: [Recipe]
}

struct Details: Codable {
    var details: Recipe
}

struct Recipe: Codable, Identifiable {
    let vegetarian: Bool
    let vegan: Bool
    let glutenFree: Bool
    let dairyFree: Bool
    let veryHealthy: Bool
    let cheap: Bool
    let veryPopular: Bool
    let sustainable: Bool
    let weightWatcherSmartPoints: Double
    let spoonacularScore: Double
    let healthScore: Double
    let pricePerServing: Double
    let extendedIngredients: [Ingredients]?
    var id: Int?
    let title: String
    let readyInMinutes: Int
    let servings: Int
    var image: String?
    var summary: String
//    let cuisines: [String]
//    let diets: [String]
    var instructions: String
    var offset: CGFloat = 0
    var ingredientsArray: [String] = []
    /// Card x position
    var x: CGFloat = 0.0
    /// Card y position
    var y: CGFloat = 0.0
    /// Card rotation angle
    var degree: Double = 0.0

    enum CodingKeys: String, CodingKey {
        case vegetarian = "vegetarian"
        case vegan = "vegan"
        case glutenFree = "glutenFree"
        case dairyFree = "dairyFree"
        case veryHealthy = "veryHealthy"
        case cheap = "cheap"
        case veryPopular = "veryPopular"
        case sustainable = "sustainable"
        case weightWatcherSmartPoints = "weightWatcherSmartPoints"
        case spoonacularScore = "spoonacularScore"
        case healthScore = "healthScore"
        case pricePerServing = "pricePerServing"
        case extendedIngredients = "extendedIngredients"
        case id = "id"
        case title = "title"
        case readyInMinutes = "readyInMinutes"
        case servings = "servings"
        case image = "image"
        case summary = "summary"
//        case cuisines = "cuisines"
//        case diets = "diets"
        case instructions = "instructions"
    }
    
    // The Initializer function from Decodable:
    init(from decoder: Decoder) throws {
        
        /*
            1. Container:
            We requested all the values from the container to store
            it in the variable values with the help of enum
            CodingKeys declared in the struct
        */
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        /*
            2. Normal Decoding:
            The values are retrieved with the help of the key and
            stored into the mentioned property
        */
        extendedIngredients = try values.decode([Ingredients].self, forKey: .extendedIngredients)
        vegetarian = try values.decode(Bool.self, forKey: .vegetarian)
        vegan = try values.decode(Bool.self, forKey: .vegan)
        glutenFree = try values.decode(Bool.self, forKey: .glutenFree)
        dairyFree = try values.decode(Bool.self, forKey: .dairyFree)
        veryHealthy = try values.decode(Bool.self, forKey: .veryHealthy)
        cheap = try values.decode(Bool.self, forKey: .cheap)
        veryPopular = try values.decode(Bool.self, forKey: .veryPopular)
        sustainable = try values.decode(Bool.self, forKey: .sustainable)
        weightWatcherSmartPoints = try values.decode(Double.self, forKey: .weightWatcherSmartPoints)
        spoonacularScore = try values.decode(Double.self, forKey: .spoonacularScore)
        healthScore = try values.decode(Double.self, forKey: .healthScore)
        pricePerServing = try values.decode(Double.self, forKey: .pricePerServing)
        servings = try values.decode(Int.self, forKey: .servings)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        readyInMinutes = try values.decode(Int.self, forKey: .readyInMinutes)

        /*
            3. Conditional Decoding:
            Decoding the value with the help of the conditional statement,
            checking if the key is present, or it has a value before retrieving
            with the help of decodeIfPresent(String.self, forKey: .image) function.
            If the condition fails, a default value is requested to be stored in the property
         */
        
        if let id =  try values.decodeIfPresent(Int.self, forKey: .id) {
            self.id = id
        } else {
            self.id = 0
        }

        if let image =  try values.decodeIfPresent(String.self, forKey: .image) {
            self.image = image
        } else {
            self.image = ""
        }
        
        if let summary =  try values.decodeIfPresent(String.self, forKey: .summary) {
            self.summary = summary
        } else {
            self.summary = ""
        }

        if let instructions =  try values.decodeIfPresent(String.self, forKey: .instructions) {
            self.instructions = instructions
        } else {
            self.instructions = ""
        }

    }
    
    // The encoding function from Encodable
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(title, forKey: .title)
        try container.encode(readyInMinutes, forKey: .readyInMinutes)

        if self.id == 0 {
            try container.encode(0, forKey: .id)
        } else {
            try container.encodeIfPresent(id, forKey: .id)
        }

        if self.image == "" {
            try container.encode("", forKey: .image)
        } else {
            try container.encodeIfPresent(image, forKey: .image)
        }

        if self.summary == "" {
            try container.encode("", forKey: .summary)
        } else {
            try container.encodeIfPresent(summary, forKey: .summary)
        }

        if self.instructions == "" {
            try container.encode("", forKey: .instructions)
        } else {
            try container.encodeIfPresent(instructions, forKey: .instructions)
        }
        
    }
    
}

extension Encodable {
    
    func encode() -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            let jsonDict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
            return jsonDict
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}


public struct Ingredients: Codable, Hashable {
    let id: Int
    let image: String
    let name: String
    let original: String
    let amount: Double
    let unit: String
}
