//
//  FavoriteController.swift
//  Navigation
//
//  Created by Liz-Mary on 29.09.2023.
//

import UIKit
import CoreData
import StorageService

class FavoriteController: UIViewController {
    
    var favoritePosts: [Post] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.favoritePostsView.tableView.reloadData()
                self?.favoritePostsView.emptyStateLabel.isHidden = !(self?.favoritePosts.isEmpty)! 
            }
        }
    }
    
    let coreDataManager = CoreDataHelper.shared
    let favoritePostsView = FavoriteView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavoritePosts()
    }
    
    private func setupUI() {
        favoritePostsView.tableView.register(PostsTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell_ReuseID")
        
        view.addSubview(favoritePostsView.tableView)
        view.addSubview(favoritePostsView.emptyStateLabel)
        
        NSLayoutConstraint.activate([
            favoritePostsView.tableView.topAnchor.constraint(equalTo: view.topAnchor),
            favoritePostsView.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoritePostsView.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoritePostsView.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            favoritePostsView.emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoritePostsView.emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        favoritePostsView.tableView.dataSource = self
        favoritePostsView.tableView.delegate = self
    }
    
    // Добавление поста в избранное
    func savePostToFavorite(_ post: Post) {
        coreDataManager.savePost(post, isFavorite: true)
        loadFavoritePosts()
    }
    
    func removePostFromFavorite(_ post: Post) {
        
        coreDataManager.deletePost(post) {
            self.coreDataManager.savePost(post, isFavorite: false)
            self.loadFavoritePosts() 
        }
    }
    
    // Загрузка избранных постов
    func loadFavoritePosts() {
        favoritePosts = coreDataManager.fetchLikedPosts()
        DispatchQueue.main.async {
            self.favoritePostsView.tableView.reloadData()
            self.favoritePostsView.emptyStateLabel.isHidden = !self.favoritePosts.isEmpty
        }
    }
}

