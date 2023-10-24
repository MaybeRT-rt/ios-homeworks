//
//  CoreDataHelper.swift
//  Navigation
//
//  Created by Liz-Mary on 29.09.2023.
//


/*
1. Решила использовать батчевые запросы в CoreData для эффективной выборки данныз из БД. Тем самым уменьшая нагрузку на память и повышая производительность.

 Основная идея батчевых запросов заключается в том, что вы не извлекаете все данные сразу, а частями (батчами). Это делает запросы более эффективными.
 
 У нас пока немного постов, но уверена, что в будущем мы будем их брать из какой-то апишки :)
 
 2. Та же мы используем сохранение в фоновом режиме для того, чтобы не блокировался главный поток.
 
 3(!) Самое актулальное в данном случае  - это кеширование данных. Что помогает нам быстрее их доставать.
 Я так понимаю, что данные которые кешируются извлекаются из локального хранилища, а не бегают запросами к бд
 
 */
import CoreData
import StorageService

class CoreDataHelper {
    
    static let shared = CoreDataHelper()
    
    private init() {}
    
    // MARK: - Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteModel")
        
        if let description = container.persistentStoreDescriptions.first {
            description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
            description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        }
        
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

    
    func savePost(_ post: Post, isFavorite: Bool) {
        let backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.parent = persistentContainer.viewContext

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

//    func deletePost(_ post: Post, completion: @escaping () -> Void) {
//        let managedContext = persistentContainer.viewContext
//
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Posts")
//        let predicate = NSPredicate(format: "postId == %@", post.postId as CVarArg)
//        fetchRequest.predicate = predicate
//
//        do {
//            let result = try managedContext.fetch(fetchRequest)
//            for postToDelete in result {
//                managedContext.delete(postToDelete)
//            }
//            
//            DispatchQueue.main.async {
//                self.saveContext()
//                print("Пост с postId \(post.postId) успешно удален из Core Data")
//                completion()
//            }
//        } catch {
//            print("Error deleting post: \(error)")
//        }
//    }

    func deletePost(_ post: Post, completion: @escaping () -> Void) {
        let managedContext = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Posts")
        let predicate = NSPredicate(format: "postId == %@", post.postId as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            if let postToDelete = result.first {
                // Удаление из Core Data
                managedContext.delete(postToDelete)
                
                // Удаление из кеша
                if var cachedLikedPosts = CachedPosts.shared.cachedLikedPosts(),
                   let index = cachedLikedPosts.firstIndex(where: { $0.postId == post.postId }) {
                    cachedLikedPosts.remove(at: index)
                    CachedPosts.shared.cacheLikedPosts(cachedLikedPosts)
                }
                
                DispatchQueue.main.async {
                    self.saveContext()
                    print("Пост с postId \(post.postId) успешно удален из Core Data и кеша")
                    completion()
                }
            } else {
                print("Пост не найден в Core Data")
            }
        } catch {
            print("Error deleting post: \(error)")
        }
    }

    
    func fetchLikedPosts() -> [Post] {
        
        if let cachedLikedPosts = CachedPosts.shared.cachedPosts {
            return cachedLikedPosts
        }
        
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Posts> = Posts.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isFavorite == true")
        fetchRequest.fetchBatchSize = 5
        fetchRequest.resultType = .managedObjectResultType
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            // Создаем массив для хранения постов
            var likedPosts: [Post] = []
            
            for coreDataPost in result {
                let post = Post(
                    postId: coreDataPost.postId ?? UUID(),
                    author: coreDataPost.author ?? "",
                    text: coreDataPost.text ?? "",
                    image: coreDataPost.image ?? "",
                    likes: Int(coreDataPost.likes),
                    view: Int(coreDataPost.view),
                    isFavorite: coreDataPost.isFavorite
                )
                likedPosts.append(post)
            }
            
            CachedPosts.shared.cacheLikedPosts(likedPosts)
            return likedPosts
        } catch let error as NSError {
            print("Could not fetch liked posts. \(error), \(error.userInfo)")
            return []
        }
    }

}
