//
//  ShowMealsService.swift
//  Fetch
//
//  Created by Ahmed Buttar on 6/9/24.
//

import Foundation
import Combine

public protocol ShowMealsUseCaseful {
    func getMeals() -> AnyPublisher<Meals, Error>
}

class ShowMealsUseCase: ShowMealsUseCaseful {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getMeals() -> AnyPublisher<Meals, Error> {
        networkService.request(request: buildRequest())
            .tryMap { response -> Meals in
                guard let data = response.data else { return [] }
                let decoder = JSONDecoder()
                return try decoder.decode(MealsResponse.self, from: data).meals
            }
            .eraseToAnyPublisher()
    }
    
    // make generic build function
    private func buildRequest() -> URLRequest {
        var components: URLComponents = URLComponents(string: "/api/json/v1/1/filter.php?c=Dessert")!
        components.scheme = "https"
        components.host = "themealdb.com"
        
        let url = components.url
        
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "GET"
                
        return urlRequest
    }
}
