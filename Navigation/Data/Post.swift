//
//  Post.swift
//  Navigation
//
//  Created by Liz-Mary on 06.04.2023.
//

import Foundation
import UIKit

struct Posts {
    var title: String
}

struct Post {
    var author: String
    var description: String
    var image: String
    var likes: Int
    var view: Int
}

extension Post {
    static func make() -> [Post] {
        [
            Post(author: "No name", description: "Пожилые жуки больше ухаживают за потомством, чем молодые.", image: "bug.jpg", likes: 10, view: 14),
            Post(author: "apple", description: "Apple работает над созданием платного тренера для помощи в поддержании здорового образа жизни Quartz на основе искусственного интеллекта. Он поможет пользователям в комплексном оздоровлении, укреплении сна и приобретении привычек здорового питания, сообщил Bloomberg. По данным ресурса, сервис Quartz будет «использовать ИИ и данные Apple Watch, чтобы вносить рекомендации и предлагать обучающие программы, адаптированные для конкретных пользователей».", image: "1.jpg", likes: 20, view: 32),
            Post(author: "Мотивационные цитаты", description: "Правило 3 Н: Нет Ничего Невозможного", image: "no.jpg", likes: 100, view: 101),
            Post(author: "My name", description: "Рада всех видеть!", image: "hello.jpg", likes: 2, view: 10)
        ]
    }
}
