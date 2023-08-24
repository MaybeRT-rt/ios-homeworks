//
//  AppDelegate.swift
//  Navigation
//
//  Created by Liz-Mary on 06.04.2023.
//

import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let operationQueue = OperationQueue()
        operationQueue.qualityOfService = .background
        
<<<<<<< HEAD
        let randomConfiguration = AppConfigurations(url: [AppConfiguration.people, AppConfiguration.films, AppConfiguration.planets].randomElement()!.url)
        
        operationQueue.addOperation {
=======
        DispatchQueue.global().async {
            

            let randomConfiguration = AppConfigurations(url: [AppConfiguration.people, AppConfiguration.films, AppConfiguration.planets].randomElement()!.url)

            
>>>>>>> b9a518b39c4e59e3b95b30206575dd282081d5c3
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
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

