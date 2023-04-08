//
//  InfoViewController.swift
//  Navigation
//
//  Created by Liz-Mary on 06.04.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        button.setTitle("Alert", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressButtonAlert), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setupButton()
    }
    
    private func setupButton() {
        self.view.addSubview(button)
        
        self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -400).isActive = true
        self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func pressButtonAlert() {
        let alert = UIAlertController(title: "someAlert", message: "someMessage", preferredStyle: UIAlertController.Style.alert )

        let actionOne = UIAlertAction(title: "Ok", style: .default) { _ in
            print("You tapped Ok")
        }
        alert.addAction(actionOne)
        
        let actionTwo = UIAlertAction(title: "Cancel", style: .default) { _ in
            print("You tapped Cancel")
        }
        alert.addAction(actionTwo)
       
        present(alert, animated: true, completion: nil)
    }
    
}
