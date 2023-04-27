//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Liz-Mary on 27.04.2023.
//

import UIKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {

    let profileView = ProfileHeaderView()
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addedSubview()
        setupConstraint()
    }
    
    private func addedSubview() {
        contentView.addSubview(profileView)
    }

    private func setupConstraint() {
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
}
