//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Liz-Mary on 06.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    fileprivate let data = Post.make()
    
    private lazy var profileTableView: UITableView = {
        
        let profileTV = UITableView.init(frame: .zero, style: .plain)
        profileTV.translatesAutoresizingMaskIntoConstraints = false
        
        return profileTV
    }()
    
    private enum CellReuseID: String {
        case base = "PostTableViewCell_ReuseID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addedSubview()
        setupContrain()
        tuneTableView()
    }
    
    private func addedSubview() {
        view.addSubview(profileTableView)
    }

    func setupContrain() {
        
        NSLayoutConstraint.activate([
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func tuneTableView() {
        profileTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: CellReuseID.base.rawValue)
        profileTableView.dataSource = self
        profileTableView.delegate = self
    }
}
    
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell_ReuseID", for: indexPath) as! PostsTableViewCell
        
        //cell = data[indexPath.row]
        //cell.update(data[indexPath.row])
        
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 220
    }

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let profileHeaderView = ProfileHeaderView()

        return profileHeaderView
    }
}
