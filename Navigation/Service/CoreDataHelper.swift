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
    
    // MARK: - Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteModel")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Core Data Saving support
    
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
    
    // MARK: - Data Management
    
    func isPostSaved(_ post: Post) -> Bool {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Posts")
        let predicate = NSPredicate(format: "postId == %@", post.postId as CVarArg)
        let textPredicate = NSPredicate(format: "text == %@", post.text)
            let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [predicate, textPredicate])
        fetchRequest.predicate = compoundPredicate
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            return !result.isEmpty
        } catch {
            print("Error checking if post is saved: \(error)")
            return false
        }
    }
    
    
//    func savePost(_ post: Post, isFavorite: Bool) {
//        let managedContext = persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Posts")
//
//        let predicate = NSPredicate(format: "postId == %@", post.postId as CVarArg)
//        fetchRequest.predicate = predicate
//
//        do {
//            let result = try managedContext.fetch(fetchRequest)
//            if let coreDataPost = result.first {
//                coreDataPost.setValue(isFavorite, forKey: "isFavorite")
//                coreDataPost.setValue(post.likes, forKey: "likes") // Обновление количества лайков
//
//                do {
//                    try managedContext.save()
//                    print("Пост с postId \(post.postId) успешно обновлен в Core Data")
//                } catch {
//                    print("Ошибка при сохранении изменений в Core Data: \(error)")
//                }
//            } else if isFavorite && post.likes > 0 { 
//                if let entityDescription = NSEntityDescription.entity(forEntityName: "Posts", in: managedContext) {
//                    let coreDataPost = NSManagedObject(entity: entityDescription, insertInto: managedContext)
//                    coreDataPost.setValue(post.postId, forKey: "postId")
//                    coreDataPost.setValue(post.author, forKey: "author")
//                    coreDataPost.setValue(post.text, forKey: "text")
//                    coreDataPost.setValue(post.image, forKey: "image")
//                    coreDataPost.setValue(post.likes, forKey: "likes")
//                    coreDataPost.setValue(post.view, forKey: "view")
//                    coreDataPost.setValue(true, forKey: "isFavorite")
//
//                    do {
//                        try managedContext.save()
//                        print("Пост с postId \(post.postId) успешно сохранен в Core Data")
//                    } catch {
//                        print("Ошибка при сохранении в Core Data: \(error)")
//                    }
//                }
//            }
//        } catch {
//            print("Ошибка при запросе или обновлении поста: \(error)")
//        }
//    }
    
    func savePost(_ post: Post, isFavorite: Bool) {
        // Создайте фоновый контекст
        let backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.parent = persistentContainer.viewContext

        // Используйте фоновый контекст для сохранения данных
        backgroundContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Posts")
            let predicate = NSPredicate(format: "postId == %@", post.postId as CVarArg)
            fetchRequest.predicate = predicate

            do {
                let result = try backgroundContext.fetch(fetchRequest)
                if let coreDataPost = result.first {
                    coreDataPost.setValue(isFavorite, forKey: "isFavorite")
                    coreDataPost.setValue(post.likes, forKey: "likes") // Обновление количества лайков

                    do {
                        try backgroundContext.save()
                        print("Пост с postId \(post.postId) успешно обновлен в Core Data (в фоновом контексте)")
                        
                        // Сохранение изменений в основном контексте
                        self.persistentContainer.viewContext.perform {
                            do {
                                try self.persistentContainer.viewContext.save()
                                print("Изменения сохранены в основном контексте")
                            } catch {
                                print("Ошибка при сохранении в основном контексте: \(error)")
                            }
                        }
                    } catch {
                        print("Ошибка при сохранении изменений в фоновом контексте: \(error)")
                    }
                } else if isFavorite && post.likes > 0 {
                    if let entityDescription = NSEntityDescription.entity(forEntityName: "Posts", in: backgroundContext) {
                        let coreDataPost = NSManagedObject(entity: entityDescription, insertInto: backgroundContext)
                        coreDataPost.setValue(post.postId, forKey: "postId")
                        coreDataPost.setValue(post.author, forKey: "author")
                        coreDataPost.setValue(post.text, forKey: "text")
                        coreDataPost.setValue(post.image, forKey: "image")
                        coreDataPost.setValue(post.likes, forKey: "likes")
                        coreDataPost.setValue(post.view, forKey: "view")
                        coreDataPost.setValue(true, forKey: "isFavorite")

                        do {
                            try backgroundContext.save()
                            print("Пост с postId \(post.postId) успешно сохранен в Core Data (в фоновом контексте)")
                            
                            // Сохранение изменений в основном контексте
                            self.persistentContainer.viewContext.perform {
                                do {
                                    try self.persistentContainer.viewContext.save()
                                    print("Изменения сохранены в основном контексте")
                                } catch {
                                    print("Ошибка при сохранении в основном контексте: \(error)")
                                }
                            }
                        } catch {
                            print("Ошибка при сохранении в фоновом контексте: \(error)")
                        }
                    }
                }
            } catch {
                print("Ошибка при запросе или обновлении поста: \(error)")
            }
        }
    }

    func deletePost(_ post: Post, completion: @escaping () -> Void) {
        let managedContext = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Posts")
        let predicate = NSPredicate(format: "postId == %@", post.postId as CVarArg)
        fetchRequest.predicate = predicate

        do {
            let result = try managedContext.fetch(fetchRequest)
            for postToDelete in result {
                managedContext.delete(postToDelete)
            }
            
            DispatchQueue.main.async {
                self.saveContext()
                print("Пост с postId \(post.postId) успешно удален из Core Data")
                completion()
            }
        } catch {
            print("Error deleting post: \(error)")
        }
    }

    
    func fetchLikedPosts() -> [Post] {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Posts")
        
        fetchRequest.predicate = NSPredicate(format: "isFavorite == true")

        do {
            let result = try managedContext.fetch(fetchRequest)
            var likedPosts: [Post] = []

            for data in result {
                guard let postId = data.value(forKey: "postId") as? UUID,
                      let author = data.value(forKey: "author") as? String,
                      let text = data.value(forKey: "text") as? String,
                      let image = data.value(forKey: "image") as? String,
                      let likes = data.value(forKey: "likes") as? Int,
                      let view = data.value(forKey: "view") as? Int else {
                    continue
                }

                let post = Post(postId: postId, author: author, text: text, image: image, likes: likes, view: view, isFavorite: true)

                likedPosts.append(post)
            }

            return likedPosts
            
        } catch let error as NSError {
            print("Could not fetch liked posts. \(error), \(error.userInfo)")
            return []
        }
    }

}
