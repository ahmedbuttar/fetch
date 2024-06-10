//
//  ShowMealUseCase.swift
//  Fetch
//
//  Created by Ahmed Buttar on 6/9/24.
//

import Foundation
import Combine

public protocol ShowMealUseCaseful {
    func getMeal(mealId: String) -> AnyPublisher<MealDetail, Error>
}

class ShowMealUseCase: ShowMealUseCaseful {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getMeal(mealId: String) -> AnyPublisher<MealDetail, Error> {
        networkService.request(request: buildRequest(mealId: mealId))
            .tryMap { response -> MealDetail in
                guard let data = response.data else { throw NSError() }
                let decoder = JSONDecoder()
                guard let meal = try decoder.decode(MealDetailResponse.self, from: data).meals.first else {
                    throw NSError()
                }
                return meal
            }
            .eraseToAnyPublisher()
    }
    
    // make generic build function
    func buildRequest(mealId: String) -> URLRequest {
        var components: URLComponents = URLComponents(string: "/api/json/v1/1/lookup.php?i=\(mealId)")!
        components.scheme = "https"
        components.host = "themealdb.com"
        
        let url = components.url
        
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "GET"
                
        return urlRequest
    }
}
