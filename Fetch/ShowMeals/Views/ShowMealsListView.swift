//
//  FetchListView.swift
//  Fetch
//
//  Created by Ahmed Buttar on 6/9/24.
//

import Foundation
import UIKit
import Combine

// TODO: make generic list view in future

public typealias ShowMealsSnapshot = NSDiffableDataSourceSnapshot<String, Meal>

public class ShowMealsListView: UIView {
    
    
    init() {
        super.init(frame: .zero)
        addSubviews()
    }
    
    func addSubviews() {
        tableview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: topAnchor),
            tableview.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableview.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableview: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.separatorStyle = .none
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(ShowMealsCell.self, forCellReuseIdentifier: "meals")
        tableview.delegate = self
        return tableview
    }()
    
    private let rowSelectedSubject = PassthroughSubject<Meal, Never>()

    
    public var rowSelected: AnyPublisher<Meal, Never> {
        rowSelectedSubject.eraseToAnyPublisher()
    }
    
    private lazy var dataSource: UITableViewDiffableDataSource<String, Meal> = {
        .init(tableView: tableview) { [weak self] tableview, indexPath, model -> UITableViewCell? in
            guard let self = self else {return nil}
            var model = model
            
            let cell = tableview.dequeueReusableCell(withIdentifier: "meals", for: indexPath) as? ShowMealsCell
            cell?.inject(name: model.name)
            
            return cell
        }
    }()
    
    public func apply(_ snapshot: ShowMealsSnapshot,
                      completion: (()-> Void)? = nil){
        dataSource.applySnapshotUsingReloadData(snapshot, completion: completion)
    }
}

extension ShowMealsListView: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let model = dataSource.itemIdentifier(for: indexPath) else {return}
        rowSelectedSubject.send(model)
    }
    
}
