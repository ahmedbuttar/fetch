//
//  ShowMealViewController.swift
//  Fetch
//
//  Created by Ahmed Buttar on 6/9/24.
//

import Foundation
import SwiftUI

class ShowMealController: UIHostingController<ShowMealView> {
    init(viewModel: ShowMealViewModel) {
        let view = ShowMealView(viewModel: viewModel)
        super.init(rootView: view)
    }

    @available(*, unavailable)
    @objc dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
