//
//  PostViewController.swift
//  Navigation
//
//  Created by Liz-Mary on 06.04.2023.
//

import UIKit

class PostViewController: UIViewController {
    
    var titlePost: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupButton()
    }
    
    private func setupView() {
        self.view.backgroundColor = .lightGray
        self.navigationItem.title = titlePost
    }
    
    func setupButton() {
        let infoButton = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(infoButtonTapped))

        navigationItem.rightBarButtonItems = [infoButton]
    }
    
    @objc private func infoButtonTapped() {
        let infoViewController = InfoViewController()
        
        infoViewController.title = "Info"
        self.navigationController?.pushViewController(infoViewController, animated: true)
    }
    
}
