//
//  PhotoGallery.swift
//  Navigation
//
//  Created by Liz-Mary on 05.05.2023.
//

import Foundation

struct PhotoGallery {
    var image: String

    static func getImage() -> [PhotoGallery] {
        var images = [PhotoGallery]()

        images.append(PhotoGallery(image: "1"))
        images.append(PhotoGallery(image: "2"))
        images.append(PhotoGallery(image: "3"))
        images.append(PhotoGallery(image: "4"))
        images.append(PhotoGallery(image: "5"))
        images.append(PhotoGallery(image: "6"))
        images.append(PhotoGallery(image: "7"))


        return images
    }
}
