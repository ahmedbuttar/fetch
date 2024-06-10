//
//  ShowMealsViewModel.swift
//  Fetch
//
//  Created by Ahmed Buttar on 6/9/24.
//

import Foundation
import Combine

protocol ShowMealsViewModelProtocol {
    func refreshData() -> AnyPublisher<ShowMealsSnapshot, Never>
}

class ShowMealsViewModel: ShowMealsViewModelProtocol {
    
    private let showMealsUseCase: ShowMealsUseCaseful
    
    init(showMealsUseCase: ShowMealsUseCaseful) {
        self.showMealsUseCase = showMealsUseCase
    }
    
    func refreshData() -> AnyPublisher<ShowMealsSnapshot, Never> {
        showMealsUseCase.getMeals()
            .receive(on: RunLoop.main)
            .catch ({ error -> AnyPublisher<Meals, Never> in
                // TODO: properly handle error with UI updates
                return Empty<Meals, Never>().eraseToAnyPublisher()
            })
            .map { meals in
                var snapshot = ShowMealsSnapshot()
                
                let section = "meals"
                snapshot.appendSections([section])
                snapshot.appendItems(meals.sorted(by: { $0.name < $1.name }), toSection: section)
                
                return snapshot
            }
            .eraseToAnyPublisher()
    }
}
