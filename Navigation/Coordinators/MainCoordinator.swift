//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Liz-Mary on 23.07.2023.
//

import UIKit

final class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let window: UIWindow
    var tabBarController = UITabBarController()
    
    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
        tabBarController.viewControllers = [navigationController]
    }
    
    func start() {
        let profileCoordinator = ProfileCoordinator()
        let feedCoordinator = FeedCoordinator()
        // var tabBarController = UITabBarController()
        
        feedCoordinator.start()
        profileCoordinator.start()
        
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 1)
        let feedTabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "list.bullet"), tag: 0)
        
        feedCoordinator.navigationController.tabBarItem = feedTabBarItem
        profileCoordinator.navigationController.tabBarItem = profileTabBarItem
        
        
        tabBarController.viewControllers = [feedCoordinator.navigationController, profileCoordinator.navigationController]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        addChildCoordinator(profileCoordinator)
        addChildCoordinator(feedCoordinator)
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
}


