//
//  CoreDataHelper.swift
//  Navigation
//
//  Created by Liz-Mary on 29.09.2023.
//

import CoreData
import StorageService

class CoreDataHelper {
    
    static let shared = CoreDataHelper()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteModel")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
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
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func isPostLiked(_ post: Post) -> Bool {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Posts")
        
        let predicate = NSPredicate(format: "author == %@ AND text == %@", post.author, post.text)
        fetchRequest.predicate = predicate
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            return !result.isEmpty
        } catch {
            print("Error checking if post is liked: \(error)")
            return false
        }
    }
    
    func savePost(_ post: Post) {
        let managedContext = persistentContainer.viewContext
        
        if !isPostLiked(post) {
            if let entityDescription = NSEntityDescription.entity(forEntityName: "Posts", in: managedContext) {
                let coreDataPost = NSManagedObject(entity: entityDescription, insertInto: managedContext)
                coreDataPost.setValue(post.author, forKey: "author")
                coreDataPost.setValue(post.text, forKey: "text")
                coreDataPost.setValue(post.image, forKey: "image")
                coreDataPost.setValue(post.likes, forKey: "likes")
                coreDataPost.setValue(post.view, forKey: "view")
                coreDataPost.setValue(true, forKey: "isFavorite")
                
                saveContext()
            }
        }
    }
    
    func deletePost(_ post: Post) {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Posts")
        
        let predicate = NSPredicate(format: "author == %@ AND text == %@", post.author, post.text)
        fetchRequest.predicate = predicate
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            if let postToDelete = result.first {
                managedContext.delete(postToDelete)
                saveContext()
            }
        } catch {
            print("Error deleting post: \(error)")
        }
    }
    
    func fetchSavedPosts() -> [Post] {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Posts")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            var savedPosts: [Post] = []
            
            for data in result {
                if let author = data.value(forKey: "author") as? String,
                   let text = data.value(forKey: "text") as? String,
                   let image = data.value(forKey: "image") as? String,
                   let likes = data.value(forKey: "likes") as? Int,
                   let view = data.value(forKey: "view") as? Int {
                    let post = Post(author: author, text: text, image: image, likes: likes, view: view, isFavorite: true)
                    savedPosts.append(post)
                }
            }
            
            return savedPosts
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
}
