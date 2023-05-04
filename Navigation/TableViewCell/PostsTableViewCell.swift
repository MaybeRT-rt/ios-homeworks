//
//  PostsTableViewCell.swift
//  Navigation
//
//  Created by Liz-Mary on 27.04.2023.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    
    private lazy var authtorLabel: UILabel = {
        var authorLabel = UILabel()
        authorLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        authorLabel.numberOfLines = 2
        authorLabel.textColor = .black
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return authorLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        return descriptionLabel
    }()
    
    private lazy var imagePostView: UIImageView = {
        let viewImage = UIImageView()
        viewImage.contentMode = .scaleAspectFit
        viewImage.backgroundColor = .black
        viewImage.translatesAutoresizingMaskIntoConstraints = false
        return viewImage
    }()
    
    private lazy var likeLabel: UILabel = {
        let likeLabel = UILabel()
        likeLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likeLabel.textColor = .black
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        return likeLabel
    }()
    
    private lazy var viewLabel: UILabel = {
        let viewLabel = UILabel()
        viewLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        viewLabel.textColor = .black
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        return viewLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addedSubview()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addedSubview() {
        contentView.addSubview(authtorLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(imagePostView)
        contentView.addSubview(likeLabel)
        contentView.addSubview(viewLabel)
    }
    
    private func setupConstraint() {
        
        NSLayoutConstraint.activate([
            
            authtorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authtorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authtorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            imagePostView.topAnchor.constraint(equalTo: authtorLabel.bottomAnchor, constant: 12),
            imagePostView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -16),
            imagePostView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagePostView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imagePostView.heightAnchor.constraint(equalTo: imagePostView.widthAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: imagePostView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        
            likeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            viewLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            
        ])
    }
    
    func update(_ model: Post) {
        authtorLabel.text = model.author
        descriptionLabel.text = model.description
        imagePostView.image = UIImage(named: model.image)
        likeLabel.text = "Likes: " + String(model.likes)
        viewLabel.text = "View: \(model.view)"
    }
}
