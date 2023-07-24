//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Liz-Mary on 23.07.2023.
//

import UIKit

class FeedCoordinator {
    
    let navigationController: UIViewController
    
    init() {
        let feedVC = FeedViewController()
        let viewModel = FeedViewModel()
        feedVC.title = "Feed"
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper.fill"), tag: 0)
        
        navigationController = UINavigationController(rootViewController: feedVC)
    }
    
    func start() {
        
    }
}
