//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Liz-Mary on 23.07.2023.
//

import UIKit

class ProfileCoordinator {
    
    let navigationController: UIViewController
    let profileVM = ProfileViewModel()
    
    init() {
        let loginFactory: LoginFactory = MyLoginFactory()
        let loginVC = LogInViewController()
        loginVC.loginDelegate = loginFactory.makeLoginInspector()
        
        let profileVC = ProfileViewController(viewModel: profileVM)
        profileVC.title = "Profile"
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 1)
        
        navigationController = UINavigationController(rootViewController: profileVC)
    }
    
    func start() {
        
    }
    
}
