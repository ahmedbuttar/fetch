//
//  Meal.swift
//  Fetch
//
//  Created by Ahmed Buttar on 6/9/24.
//

import Foundation

//make internal once list view is generic

public typealias Meals = [Meal]

struct MealsResponse: Decodable {
    var meals: Meals
}

public struct Meal: Equatable, Decodable, Hashable {
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case idMeal,
             strMeal
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .idMeal)
        name = try container.decode(String.self, forKey: .strMeal)
    }
    
    public static func == (lhs: Meal, rhs: Meal) -> Bool {
        return lhs.id == rhs.id
    }
}
