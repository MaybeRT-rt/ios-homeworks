//
//  FeedViewController.swift
//  Navigation
//
//  Created by Liz-Mary on 06.04.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post = Post(title: "Мой пост")
    
    let containerView = UIView()
    
    //MARK: - StackView
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
       
        return stack
        
    }()
    
    //MARK: - UIButtons
    private lazy var button1: UIButton = {
        let button1 = UIButton()
        button1.backgroundColor = .systemBlue
        button1.layer.cornerRadius = 12
        button1.setTitle("Open post", for: .normal)
        button1.setTitleColor(.white, for: .normal)
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        
        return button1
    }()
    
    private lazy var button2: UIButton = {
        let button2 = UIButton()
        button2.backgroundColor = .systemBlue
        button2.layer.cornerRadius = 12
        button2.setTitle("Open post", for: .normal)
        button2.setTitleColor(.white, for: .normal)
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        
        return button2
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addedSubwiew()
        setupConstraint()
    }
    
    //MARK: - Add Subwiew
    func addedSubwiew() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
    }
    
    //MARK: - Add Constraint StackView
    private func setupConstraint() {
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.button1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.button1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.button1.heightAnchor.constraint(equalToConstant: 50),
            
            self.button2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.button2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.button2.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: - Actions
    @objc private func pressButton() {
        let postViewController = PostViewController()
        
        postViewController.titlePost = post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
        
    }
}
