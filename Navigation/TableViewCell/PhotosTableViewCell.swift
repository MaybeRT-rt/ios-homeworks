//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Liz-Mary on 04.05.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    
    private lazy var photoLabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Photo"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var images: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var imageStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    private lazy var arrowButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addedSubview()
        setupConstraint()
        setupPreviews() 
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addedSubview() {
        contentView.addSubview(photoLabel)
        contentView.addSubview(arrowButton)
        //contentView.addSubview(imageStackView)
        imageStackView.addSubview(images)
        contentView.addSubview(imageStackView)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            
            photoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            arrowButton.centerYAnchor.constraint(equalTo: photoLabel.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowButton.widthAnchor.constraint(equalToConstant: 50),
            arrowButton.heightAnchor.constraint(equalToConstant: 50),
            
            imageStackView.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 12),
            imageStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            imageStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            imageStackView.heightAnchor.constraint(equalToConstant: 65),
            imageStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }

    private func setupPreviews() {
        
        let photoGallery = PhotoGallery.shared
        let shuffledPhotos = photoGallery.shuffled() // перемешивает элементы массива
        
        for photo in shuffledPhotos.prefix(4) {
            let imageView = UIImageView(image: UIImage(named: photo.image))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 6
            imageStackView.addArrangedSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(greaterThanOrEqualToConstant: (imageStackView.bounds.width - 24) / 4),
                imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
            ])
        }
    }
}

