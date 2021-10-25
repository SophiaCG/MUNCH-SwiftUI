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
    // Card x position
    var x: CGFloat = 0.0
    // Card y position
    var y: CGFloat = 0.0
    // Card rotation angle
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
    
}

public struct Ingredients: Codable, Hashable {
    let id: Int
    let image: String
    let name: String
    let original: String
    let amount: Double
    let unit: String
}
