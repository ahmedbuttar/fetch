//
//  FetchMealsViewModelTests.swift
//  FetchTests
//
//  Created by Ahmed Buttar on 6/9/24.
//

import XCTest
import Combine
@testable import Fetch

final class ShowMealsViewModelTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        cancellables = []
    }
    
    func testRefreshData_sortedByAlphabet() {
        
        let expectation = self.expectation(description: "should show meals sorted alphabetically")
        
        let showMealsUseCaseMock = ShowMealsUseCaseMock()
        let viewModel = ShowMealsViewModel(showMealsUseCase: showMealsUseCaseMock)
        let expectedMeals: Meals = [.init(id: "3", name: "Apple Pie"),
                                    .init(id: "1", name: "crepes"),
                                    .init(id: "2", name: "ice cream")]
        
        viewModel.refreshData()
            .sink { meals in
                XCTAssertEqual(meals.itemIdentifiers, expectedMeals)
                
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
        
}
