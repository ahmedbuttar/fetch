//
//  MealDetails.swift
//  Fetch
//
//  Created by Ahmed Buttar on 6/9/24.
//

import Foundation

public typealias MealDetails = [MealDetail]

struct MealDetailResponse: Decodable {
    var meals: MealDetails
}

public struct MealDetail: Equatable, Decodable, Hashable {
    let id: String
    let name: String
    let instructions: String
    let ingredients: [String]
    let measurements: [String]
    
    var ingredientsAndMeasurements: [String] {
        zip(ingredients, measurements)
            .map { (a, b) in "\u{2022} " + b + " " + a}
    }
    
    init(id: String = UUID().uuidString,
         name: String = "",
         instructions: String = "",
         ingredients: [String] = [],
         measurments: [String] = []){
        self.id = id
        self.name = name
        self.instructions = instructions
        self.ingredients = ingredients
        self.measurements = measurments
    }
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case idMeal,
             strMeal,
             strInstructions
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .idMeal)
        name = try container.decode(String.self, forKey: .strMeal)
        instructions = try container.decode(String.self, forKey: .strInstructions)
        
        let extraContainer = try decoder.container(keyedBy: CustomKey.self)
        
        let ingredientKeys = extraContainer.allKeys.filter({ $0.stringValue.hasPrefix("strIngredient")})
        
        let measurementKeys = extraContainer.allKeys.filter({ $0.stringValue.hasPrefix("strMeasure")})
        
        // tuple as key, value where key is e.g strIngredient1
        var ingredients: [(String, String)] = []
        var measurements: [(String, String)] = []
        
        for ingredientKey in ingredientKeys {
            let ingredient = try extraContainer.decode(String.self, forKey: ingredientKey)
            if !ingredient.trimmingCharacters(in: .whitespaces).isEmpty {
                ingredients.append((ingredientKey.stringValue, ingredient))
            }

        }
        
        for measurementKey in measurementKeys {
            let measurment = try extraContainer.decode(String.self, forKey: measurementKey)
            if !measurment.trimmingCharacters(in: .whitespaces).isEmpty {
                measurements.append((measurementKey.stringValue, measurment))
            }
        }
        
        // sort based on keys so ingredients and measurements are in order
        self.ingredients = ingredients.sorted(by: { $0.0 < $1.0 }).map({(a, b) in return b})
        self.measurements = measurements.sorted(by: { $0.0 < $1.0 }).map({(a, b) in return b})
    }
    
    public static func == (lhs: MealDetail, rhs: MealDetail) -> Bool {
        return lhs.id == rhs.id
    }
}


struct CustomKey: CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    init?(intValue: Int) {
        return nil
    }
}
