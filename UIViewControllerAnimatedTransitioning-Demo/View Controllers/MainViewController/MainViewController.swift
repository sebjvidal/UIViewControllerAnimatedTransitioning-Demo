//
//  MainViewController.swift
//  UIViewControllerAnimatedTransitioning-Demo
//
//  Created by Seb Vidal on 27/01/2023.
//

import UIKit

class MainViewController: UITableViewController {
    private let stores: [Store] = Array(1...10).map { _ in
        return Store.mock
    }
    
    init() {
        super.init(style: .plain)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell else {
            fatalError("Failed to dequeueReusableCell(withIdentifier:)")
        }
        
        let store = stores[indexPath.row]
        cell.configure(with: store)
        
        return cell
    }
    
    private var navigationControllerDelegate: NavigationControllerDelegate?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let frameInTableView = tableView.rectForRow(at: indexPath)
        let frameInSuperview = tableView.convert(frameInTableView, to: tableView.superview)
        let startingPoint = CGPoint(x: frameInSuperview.minX, y: frameInSuperview.minY)
        navigationControllerDelegate = NavigationControllerDelegate(startingPoint: startingPoint)
        
        let store = stores[indexPath.row]
        let detailViewController = DetailViewController(store: store)
        navigationController?.delegate = navigationControllerDelegate
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
