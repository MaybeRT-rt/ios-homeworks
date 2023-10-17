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
    
    var authorFilter: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let resetButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetButtonTapped))
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItems = [resetButton, searchButton]
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
    
    @objc func searchButtonTapped() {
        let alertController = UIAlertController(title: "Фильтр по автору", message: "Введите имя автора", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Имя автора"
        }
        
        let applyAction = UIAlertAction(title: "Применить", style: .default) { [weak self] _ in
            if let authorTextField = alertController.textFields?.first, let author = authorTextField.text, !author.isEmpty {
                self?.authorFilter = author
            } else {
                self?.authorFilter = nil
            }
            self?.updateFilter()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertController.addAction(applyAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func resetButtonTapped() {
        authorFilter = nil
        updateFilter()
    }
    
    func updateFilter() {
        print("Author filter: \(authorFilter ?? "nil")")
        
        var filteredPosts: [Post]
        
        if let authorFilter = authorFilter, !authorFilter.isEmpty {
            filteredPosts = favoritePosts.filter { $0.author.lowercased() == authorFilter.lowercased() }
            print("Filtered posts by author: \(filteredPosts)")
        } else {
            print("No author filter applied.")
            filteredPosts = favoritePosts
        }
        
        updateTableView(with: filteredPosts)
    }

    func updateTableView(with posts: [Post]) {
        favoritePosts = posts
        self.favoritePostsView.tableView.reloadData()
    }
}
