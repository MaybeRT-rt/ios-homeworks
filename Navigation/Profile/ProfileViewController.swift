//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Liz-Mary on 06.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileHV = ProfileHeaderView()
    
    //MARK: - Button
    private lazy var buttonProfileGreat: UIButton = {
        let buttonGreat = UIButton()
        buttonGreat.backgroundColor = .systemBlue
        buttonGreat.layer.cornerRadius = 4
        buttonGreat.layer.shadowOffset = CGSize(width: 4, height: 4)
        buttonGreat.layer.shadowRadius = CGFloat(4)
        buttonGreat.layer.shadowColor = UIColor.black.cgColor
        buttonGreat.layer.shadowOpacity = 0.7
        buttonGreat.setTitle("do well", for: .normal)
        buttonGreat.setTitleColor(.white, for: .normal)
        buttonGreat.translatesAutoresizingMaskIntoConstraints = false
        buttonGreat.addTarget(self, action: #selector(pressButtonGreat), for: .touchUpInside)
        
        return buttonGreat
        
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHV.translatesAutoresizingMaskIntoConstraints = false
        addedSubwiew()
        setupConstraintProfile()
        setupConstraintButton()
    }
    
    //MARK: - Add Subwiew
    func addedSubwiew() {
        view.addSubview(profileHV)
        view.addSubview(buttonProfileGreat)
    }
    
    //MARK: - Add Constraint
    func setupConstraintProfile() {
        NSLayoutConstraint.activate([
            profileHV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            profileHV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            profileHV.heightAnchor.constraint(equalToConstant: 220)
            
        ])
    }
    
    func setupConstraintButton() {
        NSLayoutConstraint.activate([
            buttonProfileGreat.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonProfileGreat.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            buttonProfileGreat.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            buttonProfileGreat.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func pressButtonGreat() {
        let alert = UIAlertController(title: "It's soo good", message: "Great?", preferredStyle: UIAlertController.Style.alert )
        
        let action = UIAlertAction(title: "To do well", style: .default) { _ in
            print("Well")
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
