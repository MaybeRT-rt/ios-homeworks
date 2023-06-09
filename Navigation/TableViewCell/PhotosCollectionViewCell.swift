//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Liz-Mary on 07.05.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    var photo: UIImageView = {
    let photos = UIImageView()
    photos.translatesAutoresizingMaskIntoConstraints = false
    return photos
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(photo)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func configCellCollection(photo: UIImage) {
        self.photo.image = photo
    }
}


