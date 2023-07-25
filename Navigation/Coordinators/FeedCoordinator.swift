//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Liz-Mary on 23.07.2023.
//

import UIKit

final class FeedCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    let feed = FeedViewModel()
    
    init() {
        let feedVC = FeedViewController(viewModelFeed: feed)
        
        navigationController = UINavigationController(rootViewController: feedVC)
    }
    
    func start() {
        
        let feedVC = FeedViewController(viewModelFeed: feed)
        feedVC.title = "Feed"
        
        navigationController.setViewControllers([feedVC], animated: false)
    }
}
