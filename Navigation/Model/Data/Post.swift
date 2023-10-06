//
//  Post.swift
//  Navigation
//
//  Created by Liz-Mary on 06.04.2023.
//

import Foundation
import UIKit

public struct Posts {
    public var title: String
    
    public init(title: String) {
          self.title = title
      }
}

public struct Post {
    public var author: String
    public var text: String
    public var image: String
    public var likes: Int
    public var view: Int
    public var isFavorite: Bool

    public init(author: String, text: String, image: String, likes: Int, view: Int, isFavorite: Bool) {
        self.author = author
        self.text = text
        self.image = image
        self.likes = likes
        self.view = view
        self.isFavorite = isFavorite
    }
}


extension Post {
    public static func make() -> [Post] {
        [
            Post(author: "No name", text: "Пожилые жуки больше ухаживают за потомством, чем молодые.", image: "bug.jpg", likes: 10, view: 14, isFavorite: false),
            Post(author: "apple", text: "Apple работает над созданием платного тренера для помощи в поддержании здорового образа жизни Quartz на основе искусственного интеллекта. Он поможет пользователям в комплексном оздоровлении, укреплении сна и приобретении привычек здорового питания, сообщил Bloomberg. По данным ресурса, сервис Quartz будет «использовать ИИ и данные Apple Watch, чтобы вносить рекомендации и предлагать обучающие программы, адаптированные для конкретных пользователей».", image: "1.jpg", likes: 20, view: 32, isFavorite: false),
            Post(author: "Мотивационные цитаты", text: "Правило 3 Н: Нет Ничего Невозможного", image: "no.jpg", likes: 100, view: 101, isFavorite: false),
            Post(author: "My name", text: "Рада всех видеть!", image: "hello.jpg", likes: 2, view: 10, isFavorite: false),
            Post(author: "My", text: "WOW", image: "hello.jpg", likes: 0, view: 0, isFavorite: false)
        ]
    }
}
