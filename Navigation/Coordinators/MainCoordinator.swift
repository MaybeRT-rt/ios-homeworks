//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Liz-Mary on 23.07.2023.
//

import UIKit

final class MainCoordinator {
    private let window: UIWindow
    private let loginFactory: LoginFactory?
    var tabBarConroller: UITabBarController?
    var profileCoordinator = ProfileCoordinator()
    var feedCoordinator = FeedCoordinator()
    
    
    init(window: UIWindow, loginFactory: LoginFactory?) {
        self.window = window
        self.loginFactory = loginFactory
    }
    
    func start() {
        tabBarConroller = UITabBarController()
        window.rootViewController = tabBarConroller
        window.makeKeyAndVisible()
        
        tabBarConroller?.viewControllers = [feedCoordinator.navigationController, profileCoordinator.navigationController]
        
        feedCoordinator.start()
        profileCoordinator.start()
    }
    
}


