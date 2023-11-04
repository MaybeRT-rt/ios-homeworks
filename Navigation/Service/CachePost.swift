//
//  CachePost.swift
//  Navigation
//
//  Created by Liz-Mary on 24.10.2023.
//

import Foundation
import StorageService

class CachedPosts {
    static let shared = CachedPosts()
    
    var cachedPosts: [Post]?
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handlePostSavedToCoreData), name: Notification.Name("PostSavedToCoreData"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private let cache = NSCache<NSString, NSArray>()
    
    func cacheLikedPosts(_ posts: [Post]) {
        let array = NSArray(array: posts)
        cache.setObject(array, forKey: "likedPosts")
    }
    
    func cachedLikedPosts() -> [Post]? {
        if let cachedArray = cache.object(forKey: "likedPosts") as? [Post] {
            return cachedArray
        }
        return nil
    }
    
    func cacheUpdatedData(_ updatedData: [Post]) {
        self.cachedPosts = updatedData
    }
    
    @objc func handlePostSavedToCoreData(notification: Notification) {
        if let updatedData = notification.object as? [Post] {
            cacheUpdatedData(updatedData)
        }
    }
}
