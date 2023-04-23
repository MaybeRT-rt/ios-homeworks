//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Liz-Mary on 06.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let feedVC = FeedViewController()
        //let profileVC = ProfileViewController()
        let loginVC =  LogInViewController()
        let window = UIWindow(windowScene: scene)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [feedVC, loginVC]
        
        window.rootViewController = createTBController()
        window.makeKeyAndVisible()
        
        self.window = window
    }
    
    func creatFeedNC() -> UINavigationController {
        let feedVC = FeedViewController()
        feedVC.title = "Feed"
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper.fill"), tag: 0)
        
        return UINavigationController(rootViewController: feedVC)
        
    }
    
    func logInProfile() -> UINavigationController {
            let loginVC = LogInViewController()
            //profileVC.title = "Profile"
            loginVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 1)
            
            return UINavigationController(rootViewController: loginVC)
        }
    
    func creatProfileNC() -> UINavigationController {
            let profileVC = ProfileViewController()
            profileVC.title = "Profile"
            profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 1)

            return UINavigationController(rootViewController: profileVC)
        }
    
    func createTBController() -> UITabBarController {
        let tbController = UITabBarController()
        UITabBar.appearance().backgroundColor = .white
        tbController.viewControllers = [creatFeedNC(), logInProfile()]
        
        return tbController
    }
    
}
