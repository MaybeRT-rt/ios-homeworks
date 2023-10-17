//
//  EctensionTB.swift
//  Navigation
//
//  Created by Liz-Mary on 01.10.2023.private
//

import Foundation
import UIKit

extension FavoriteController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell_ReuseID", for: indexPath) as! PostsTableViewCell
        let post = favoritePosts[indexPath.row]
        
        if post.isFavorite {
               cell.likeImageView.tintColor = .red
           } else {
               cell.likeImageView.tintColor = .gray 
           }
        
        cell.update(post)
        
        cell.updateTableViewClosure = { [weak self] in
            self?.favoritePostsView.tableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (_, _, completionHandler) in
            if let postToRemove = self?.favoritePosts[indexPath.row] {
                self?.removePostFromFavorite(postToRemove)
                self?.loadFavoritePosts() 
            }
            completionHandler(true)
        }

        deleteAction.backgroundColor = .gray

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])

        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = favoritePosts[indexPath.row]
        removePostFromFavorite(post)
    }
}
