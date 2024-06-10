//
//  ShowMealsViewController.swift
//  Fetch
//
//  Created by Ahmed Buttar on 6/9/24.
//

import Foundation
import UIKit
import Combine

class ShowMealsViewController: UIViewController {
    
    private let listView = ShowMealsListView()
    private let viewModel = ShowMealsViewModel(showMealsUseCase: ShowMealsUseCase(networkService: NetworkService()))
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        setBindings()
        
        view.backgroundColor = .white
        title = "Desserts"
    }
    
    func addSubviews() {
        listView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(listView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            listView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

extension ShowMealsViewController {
    func setBindings() {
        viewModel.refreshData()
            .sink { [weak self] snapshot in
                guard let self = self else { return }
                self.listView.apply(snapshot)
            }
            .store(in: &cancellables)
        
        listView.rowSelected
            .sink { [weak self] meal in
                let hostingController = ShowMealController(viewModel: .init(showMealUseCase: ShowMealUseCase(networkService: NetworkService()),
                                                                            mealId: meal.id))
                self?.navigationController?.pushViewController(hostingController, animated: true)
            }
            .store(in: &cancellables)
    }
}
