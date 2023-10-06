//
//  FavoriteController.swift
//  Navigation
//
//  Created by Liz-Mary on 29.09.2023.
//

import StorageService
import UIKit

class FavoriteController: UIViewController {
    
    var favoritePosts: [Post] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.favoritePostsView.tableView.reloadData()
            }
        }
    }
    
    var updateTableViewClosure: (() -> Void)?
    
    let coreDataManager = CoreDataHelper.shared
    
    private let favoritePostsView = FavoriteView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        loadFavoritePosts()
        
        updateTableViewClosure = { [weak self] in
            self?.favoritePostsView.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavoritePosts()
    }
    
    private func setupUI() {
        favoritePostsView.tableView.register(PostsTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell_ReuseID")
        
        view.addSubview(favoritePostsView.tableView)
        NSLayoutConstraint.activate([
            favoritePostsView.tableView.topAnchor.constraint(equalTo: view.topAnchor),
            favoritePostsView.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoritePostsView.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoritePostsView.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        favoritePostsView.tableView.dataSource = self
        favoritePostsView.tableView.delegate = self
    }
    
    @objc func updateTableView() {
        favoritePostsView.tableView.reloadData()
    }
    
    private func loadFavoritePosts() {
        favoritePosts = coreDataManager.fetchSavedPosts()
        updateTableViewClosure?()
    }
    
    
    func savePostToFavorite(_ post: Post) {
        coreDataManager.savePost(post)
        loadFavoritePosts()
        updateTableViewClosure?()
        //favoritePostsView.tableView.reloadData()
        //updateTableView()
    }
    
    
    func removePostFromFavorite(_ post: Post) {
        coreDataManager.deletePost(post)
        
        if let index = favoritePosts.firstIndex(where: { $0.author == post.author && $0.text == post.text }) {
            favoritePosts.remove(at: index)
        }
        updateTableViewClosure?()
        // favoritePostsView.tableView.reloadData()
        //updateTableView()
    }
}
    
//    func updateTableView() {
//        DispatchQueue.main.async {
//            self.favoritePostsView.tableView.reloadData()
//        }
//    }
//}
