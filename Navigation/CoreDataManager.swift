//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Liz-Mary on 26.09.2023.
//

import Foundation
import CoreData
import StorageService

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoritePosts")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
    
    func saveFavoritePost(author: String, text: String, image: String, likes: Bool, view: Int16) {
        let context = persistentContainer.viewContext
        
        if let entityDescription = NSEntityDescription.entity(forEntityName: "Posts", in: context) {
            let newFavoritePublication = NSManagedObject(entity: entityDescription, insertInto: context)
            newFavoritePublication.setValue(author, forKey: "author")
            newFavoritePublication.setValue(text, forKey: "text")
            newFavoritePublication.setValue(image, forKey: "image")
            newFavoritePublication.setValue(likes, forKey: "likes")
            newFavoritePublication.setValue(view, forKey: "view")
            saveContext()
        } else {
            print("Entity 'PostLike' not found in the data model")
        }
    }
    
    func fetchFavoritePosts() {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Posts> = Posts.fetchRequest()
        
        do {
            let favoritePosts = try context.fetch(fetchRequest)
            // Далее обрабатывайте полученные понравившиеся посты
        } catch {
            print("Error fetching favorite posts: \(error)")
        }
    }
}
