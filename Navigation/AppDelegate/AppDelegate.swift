//
//  AppDelegate.swift
//  Navigation
//
//  Created by Liz-Mary on 06.04.2023.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        DispatchQueue.global().async {
            
            let randomConfiguration = AppConfigurations(url: [AppConfiguration.people, AppConfiguration.films, AppConfiguration.planets].randomElement()!.url)
            
            NetworkService.request(for: randomConfiguration) { result in
                switch result {
                case .success(let response):
                    print("Response:", response)
                case .failure(let error):
                    print("Error:", error)
                }
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

func applicationWillTerminate(_ application: UIApplication) {
    do {
        try Auth.auth().signOut()
    } catch {
        print("error")
        
    }
}
