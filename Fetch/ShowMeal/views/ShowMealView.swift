//
//  ShowMealView.swift
//  Fetch
//
//  Created by Ahmed Buttar on 6/9/24.
//

import Foundation
import SwiftUI

struct ShowMealView: View {
    @ObservedObject private var viewModel: ShowMealViewModel
    
    public init(viewModel: ShowMealViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(viewModel.mealDetail.name)
                    .padding(10)
                    .font(.bold(.title)())
                Text("Instructions")
                    .font(.title2)
                    .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                Text(viewModel.mealDetail.instructions)
                    .padding(10)
                    .font(.subheadline)
                Text("Ingredients and Measurements")
                    .padding(10)
                    .font(.title3)
                ForEach(viewModel.mealDetail.ingredientsAndMeasurements, id: \.self) { item in
                    Text(item)
                        .font(.body)
                        .padding(.init(top: 4, leading: 10, bottom: 0, trailing: 10))
                }
            }
        }
        .onAppear {
            viewModel.getMeal()
        }
    }
}
