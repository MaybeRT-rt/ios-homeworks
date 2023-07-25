//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Liz-Mary on 23.07.2023.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    let profileVM = ProfileViewModel()

    init() {
        navigationController = UINavigationController()
    }

    func start() {
        let loginFactory: LoginFactory = MyLoginFactory()
        let loginVC = LogInViewController()
        loginVC.loginDelegate = loginFactory.makeLoginInspector()
        loginVC.coordinator = self
        navigationController.setViewControllers([loginVC], animated: false)
    }

    func showProfile(for user: User) {
        let profileVC = ProfileViewController(viewModel: profileVM)
        profileVC.user = user
        navigationController.pushViewController(profileVC, animated: true)
    }
}
