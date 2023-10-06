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
            
            cell.update(post)
            
            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let post = favoritePosts[indexPath.row]
            removePostFromFavorite(post)
        }
}
