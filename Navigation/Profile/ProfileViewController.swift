//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Liz-Mary on 06.04.2023.
//

import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    fileprivate let data = Post.make()
    
    var user: User?
    
    private lazy var profileTableView: UITableView = {
        
        let profileTV = UITableView.init(frame: .zero, style: .grouped)
        profileTV.translatesAutoresizingMaskIntoConstraints = false
        
        return profileTV
    }()
    
    private enum CellReuseID: String {
        case base = "PostTableViewCell_ReuseID"
        case photos = "PhotoTableViewCell_ReuseID"
        case headerID = "profileHeaderView"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeBackgraund() 
        addedSubview()
        setupContrain()
        tuneTableView()
    }
    
    private func changeBackgraund() {
#if DEBUG
        view.backgroundColor = .systemGray
        profileTableView.backgroundColor = .systemGray
#else
        view.backgroundColor = .systemBackground
#endif
    }
    
    private func addedSubview() {
        view.addSubview(profileTableView)
        
    }
    
    func setupContrain() {
        NSLayoutConstraint.activate([
            profileTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    private func tuneTableView() {
        profileTableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: CellReuseID.headerID.rawValue)
        profileTableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: CellReuseID.photos.rawValue)
        profileTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: CellReuseID.base.rawValue)
        
        profileTableView.dataSource = self
        profileTableView.delegate = self
        
        profileTableView.rowHeight = UITableView.automaticDimension
        profileTableView.estimatedRowHeight = 1000
        
    }
}
  
    
extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return data.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: PhotosTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell_ReuseID", for: indexPath)) as! PhotosTableViewCell
            return cell
        case 1:
            let cell: PostsTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell_ReuseID", for: indexPath)) as! PostsTableViewCell
            cell.selectionStyle = .none

            let model = data[indexPath.row]
            cell.update(model)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section == 0 ? 220 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let profileHeaderView = ProfileHeaderView()
            if let user = user {
                profileHeaderView.nameLabel.text = user.fullName
                profileHeaderView.photoImageView.image = user.avatar
                profileHeaderView.myLabel.text = user.status
            }
            return profileHeaderView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? PhotosTableViewCell, cell.reuseIdentifier == "PhotoTableViewCell_ReuseID" {
            let galleryViewController = PhotosViewController()
            
            guard let navigationController = self.navigationController else { return }
            navigationController.pushViewController(galleryViewController, animated: true)
        }
    }
}
