//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Liz-Mary on 06.05.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    var gallery = PhotoGallery.shared.images
    let collectionID = "photosCollectionView"
    
    private let imageProcessor = ImageProcessor()
    
    lazy var photoCollection: UICollectionViewFlowLayout = {
        let photoLayout = UICollectionViewFlowLayout()
        photoLayout.scrollDirection = .vertical
        photoLayout.minimumLineSpacing = 8
        photoLayout.minimumInteritemSpacing = 8
        photoLayout.sectionInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        return photoLayout
    }()
    
    lazy var photosCollectionView: UICollectionView = {
        let photos = UICollectionView(frame: .zero, collectionViewLayout: photoCollection)
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
        loadingImagesInGallery()
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
    
    // .userInteractive - 0.90 секунды
    // .userInitiated - 0.92 секунды
    // .utility - 0.98 секунды
    // .background - 4 секунды
    // .default - 0.98 секунды
    
    private func loadingImagesInGallery() {
        
        var images = [UIImage]()
        for image in gallery {
            images.append(image)
        }
        
        let filters: ColorFilter = .posterize
        
        let start = DispatchTime.now()
        
        imageProcessor.processImagesOnThread(sourceImages: images, filter: filters, qos: .utility, completion: { processedImages in
            
            DispatchQueue.main.async {
                self.gallery.removeAll()
                for processImage in processedImages {
                    guard let processedImage = processImage else { continue }
                    
                    self.gallery.append(UIImage(cgImage: processedImage))
                }
                
                self.photosCollectionView.reloadData()
                
                let finish = DispatchTime.now()
                
                let updateInSeconds = Double(finish.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000
                print("Время обработки изображений: \(updateInSeconds) секунд")
            }
        })
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionID, for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        let photo = gallery[indexPath.item]
        cell.configCellCollection(photo: photo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoViewerVC = PhotosViewerViewController()
        photoViewerVC.photos = gallery
        photoViewerVC.currentIndex = indexPath.item
        present(photoViewerVC, animated: true, completion: nil)
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



