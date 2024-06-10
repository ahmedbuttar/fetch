//
//  FetchMealsUseCaseMock.swift
//  FetchTests
//
//  Created by Ahmed Buttar on 6/9/24.
//

import Foundation
import Combine
@testable import Fetch

class ShowMealsUseCaseMock: ShowMealsUseCaseful {
    
    func getMeals() -> AnyPublisher<Meals, Error> {
        let meals: Meals = [.init(id: "1", name: "crepes"), .init(id: "2", name: "ice cream"), .init(id: "3", name: "Apple Pie")]
        return Just(meals).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
}
