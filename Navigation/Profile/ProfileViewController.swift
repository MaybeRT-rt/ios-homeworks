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
        
        let profileTV = UITableView.init(frame: .zero, style: .grouped)
        profileTV.translatesAutoresizingMaskIntoConstraints = false
        
        return profileTV
    }()
    
    private enum CellReuseID: String {
        case base = "PostTableViewCell_ReuseID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addedSubview()
        setupContrain()
        tuneTableView()
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
        profileTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: CellReuseID.base.rawValue)
        
        profileTableView.dataSource = self
        profileTableView.delegate = self
        
        profileTableView.rowHeight = UITableView.automaticDimension
        profileTableView.estimatedRowHeight = 1000
        
    }
}
    
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PostsTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell_ReuseID", for: indexPath) as? PostsTableViewCell) else {
            return UITableViewCell()
        }
       
        let model = data[indexPath.row]
        cell.update(model)
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 220
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let profileHeaderView = ProfileHeaderView()

        return profileHeaderView
    }
}
