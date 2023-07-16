//
//  PhotoGallery.swift
//  Navigation
//
//  Created by Liz-Mary on 05.05.2023.
//

import Foundation
import UIKit

struct PhotoGallery {
    var images: [UIImage]
    
    static let shared = PhotoGallery(images: getImage())

    static func getImage() -> [UIImage] {
        var images = [UIImage]()
        
        images.append(UIImage(named: "1")!)
        images.append(UIImage(named: "2")!)
        images.append(UIImage(named: "3")!)
        images.append(UIImage(named: "4")!)
        images.append(UIImage(named: "5")!)
        images.append(UIImage(named: "6")!)
        images.append(UIImage(named: "7")!)
        images.append(UIImage(named: "8")!)
        images.append(UIImage(named: "9")!)
        images.append(UIImage(named: "10")!)
        images.append(UIImage(named: "11")!)
        images.append(UIImage(named: "bich8.png")!)
        images.append(UIImage(named: "bich7.png")!)
        images.append(UIImage(named: "bich6.png")!)
        images.append(UIImage(named: "bich5.png")!)
        images.append(UIImage(named: "bich4.png")!)
        images.append(UIImage(named: "bich3.png")!)
        images.append(UIImage(named: "bich2.png")!)
        images.append(UIImage(named: "bich.png")!)
        
        return images
    }
}
