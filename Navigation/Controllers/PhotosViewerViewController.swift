//
//  PhotosViewerViewController.swift
//  Navigation
//
//  Created by Liz-Mary on 02.08.2023.
//



/*
 Таймер - позволяет удобно реализовать просмотр фото по средстам слайдшоу.
 */

import UIKit

class PhotosViewerViewController: UIViewController {
    
    var photos: [UIImage]?
    var currentIndex: Int = 0
    var selectedImage: UIImage?
    var timer: Timer?
    var isSlideshowRunning = false
    
    private var images: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let slideshowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Слайд-шоу", for: .normal)
        button.addTarget(self, action: #selector(slideshowButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        tabBarController?.tabBar.isHidden = true
        setupView()
        displayCurrentPhoto()
    }
    
    private func setupView() {
        view.addSubview(images)
        view.addSubview(closeButton)
        view.addSubview(slideshowButton)
        
        NSLayoutConstraint.activate([
            images.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            images.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            images.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            images.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            slideshowButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            slideshowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func displayCurrentPhoto() {
        guard let photos = photos, !photos.isEmpty, currentIndex >= 0, currentIndex < photos.count else {
            images.image = nil
            return
        }
        images.image = photos[currentIndex]
    }
    
    @objc private func imageTapped() {
        guard let photos = photos, currentIndex >= 0, currentIndex < photos.count else {
            return
        }
        selectedImage = photos[currentIndex]
        displaySelectedImage()
    }
    
    private func displaySelectedImage() {
        images.image = selectedImage
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
        stopSlideshow()
    }
    
    @objc private func slideshowButtonTapped() {
        if isSlideshowRunning {
            stopSlideshow()
        } else {
            startSlideshow()
        }
    }
    
    private func startSlideshow() {
        if timer == nil {
            isSlideshowRunning = true
            slideshowButton.setTitle("Остановить", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(showNextPhoto), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: .common)
        }
    }
    
    private func stopSlideshow() {
        isSlideshowRunning = false
        slideshowButton.setTitle("Слайд-шоу", for: .normal)
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func showNextPhoto() {
        guard let photos = photos, !photos.isEmpty else {
            stopSlideshow()
            return
        }
        
        currentIndex = (currentIndex + 1) % photos.count
        displayCurrentPhoto()
    }
}
