//
//  PhotoGallery.swift
//  Navigation
//
//  Created by Liz-Mary on 05.05.2023.
//

import Foundation
import UIKit

struct PhotoGallery {
    var image: String
    

    static let shared = getImage()

    static func getImage() -> [PhotoGallery] {
        var images = [PhotoGallery]()
    
        images.append(PhotoGallery(image: "1"))
        images.append(PhotoGallery(image: "2"))
        images.append(PhotoGallery(image: "3"))
        images.append(PhotoGallery(image: "4"))
        images.append(PhotoGallery(image: "5"))
        images.append(PhotoGallery(image: "6"))
        images.append(PhotoGallery(image: "7"))
        images.append(PhotoGallery(image: "8"))
        images.append(PhotoGallery(image: "9"))
        images.append(PhotoGallery(image: "10"))
        images.append(PhotoGallery(image: "11"))
        images.append(PhotoGallery(image: "bich8.png"))
        images.append(PhotoGallery(image: "bich7.png"))
        images.append(PhotoGallery(image: "bich6.png"))
        images.append(PhotoGallery(image: "bich5.png"))
        images.append(PhotoGallery(image: "bich4.png"))
        images.append(PhotoGallery(image: "bich3.png"))
        images.append(PhotoGallery(image: "bich2.png"))
        images.append(PhotoGallery(image: "bich.png"))
        
        return images
    }
}
