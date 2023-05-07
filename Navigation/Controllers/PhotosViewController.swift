//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Liz-Mary on 06.05.2023.
//

import UIKit

class PhotosViewController: UIViewController {
    
    let gallery = PhotoGallery.shared
    
    let collectionID = "photosCollectionView"
    
    lazy var photoLayoutCollection: UICollectionViewFlowLayout = {
        let photoLayout = UICollectionViewFlowLayout()
        photoLayout.scrollDirection = .vertical
        photoLayout.minimumLineSpacing = 8
        photoLayout.minimumInteritemSpacing = 8
        photoLayout.sectionInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        return photoLayout
    }()
    
    lazy var photosCollectionView: UICollectionView = {
        let photos = UICollectionView(frame: .zero, collectionViewLayout: photoLayoutCollection)
        photos.translatesAutoresizingMaskIntoConstraints = false
        photos.backgroundColor = .white
        photos.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: collectionID)
        return photos
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Photo Gallery"
        navigationController?.setNavigationBarHidden(false, animated: true)
        setupView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.navigationBar.isHidden = false
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.navigationBar.isHidden = true
        }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(photosCollectionView)
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotoGallery.shared.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionID, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        let photo = gallery[indexPath.item]
        guard let imageView = UIImage(named: photo.image) else { return UICollectionViewCell() }
        cell.configCellCollection(photo: imageView)
        return cell
    }
    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count: CGFloat = 3
        let width = collectionView.frame.width - 32
        let widthItem = (width / count)
        
        return CGSize(width: widthItem, height: widthItem * 1)
    }
}

