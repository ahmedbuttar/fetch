//
//  ShowMealViewModel.swift
//  Fetch
//
//  Created by Ahmed Buttar on 6/9/24.
//

import SwiftUI
import Combine

class ShowMealViewModel: ObservableObject {
    
    @Published private(set) var mealDetail: MealDetail = MealDetail()
    private let showMealUseCase: ShowMealUseCaseful
    private let mealId: String
    
    private var cancellables = Set<AnyCancellable>()
    
    init(showMealUseCase: ShowMealUseCaseful, mealId: String) {
        self.showMealUseCase = showMealUseCase
        self.mealId = mealId
    }
    
    func getMeal() {
        showMealUseCase.getMeal(mealId: mealId)
            .receive(on: RunLoop.main)
            .catch { error -> AnyPublisher<MealDetail, Never> in
                return Empty<MealDetail, Never>().eraseToAnyPublisher()
            }
            .assign(to: &$mealDetail)
    }
}
