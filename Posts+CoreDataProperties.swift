//
//  Posts+CoreDataProperties.swift
//  
//
//  Created by Liz-Mary on 06.10.2023.
//
//

import Foundation
import CoreData


extension Posts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Posts> {
        return NSFetchRequest<Posts>(entityName: "Posts")
    }
    @NSManaged public let postId: UUID
    @NSManaged public var author: String?
    @NSManaged public var text: String?
    @NSManaged public var image: String?
    @NSManaged public var likes: Int64
    @NSManaged public var view: Int64
    @NSManaged public var isFavorite: Bool

}