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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = favoritePosts[indexPath.row]
        removePostFromFavorite(post)
    }
}
