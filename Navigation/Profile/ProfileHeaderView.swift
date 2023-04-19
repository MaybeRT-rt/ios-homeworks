//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Liz-Mary on 11.04.2023.
//

import Foundation
import UIKit

class ProfileHeaderView: UIView, UITextFieldDelegate {
    
    //MARK: - Status Label
    
    private lazy var myLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    //MARK: - Name Label
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.text = "No name"
        name.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        name.textColor = .black
        name.translatesAutoresizingMaskIntoConstraints = false
        
        return name
        
    }()
    
    //MARK: - ImageView Avatar
    
    let photoImageView: UIImageView = {
        let photo = UIImageView()
        photo.layer.cornerRadius = 50
        photo.layer.borderWidth = 3
        photo.layer.borderColor = UIColor.white.cgColor
        photo.clipsToBounds = true
        photo.image = UIImage(named: "bich2")
        photo.translatesAutoresizingMaskIntoConstraints = false
        
        return photo
        
    }()
    
    //MARK: - Status
    
    private var statusText: String = ""
    
    
    //MARK: - TextField Status
    
    private lazy var statusTextField: UITextField = {
        var myTextField = UITextField()
        myTextField.placeholder = "Waiting for something"
        myTextField.text = " "
        myTextField.borderStyle = UITextField.BorderStyle.none
        myTextField.layer.backgroundColor = UIColor.white.cgColor
        myTextField.layer.borderWidth = 1
        myTextField.layer.borderColor = UIColor.black.cgColor
        myTextField.layer.cornerRadius = 12
        myTextField.minimumFontSize = 15
        myTextField.textColor = UIColor.black
        myTextField.delegate = self
        myTextField.translatesAutoresizingMaskIntoConstraints = false
        myTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        return myTextField
    }()
    
    //MARK: - Button
    
    private lazy var buttonProfile: UIButton = {
        let button = UIButton()
        buttonProfile = UIButton(frame: CGRect(x: 166, y: 264, width: 200.00, height: 50))
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = CGFloat(4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        
        return button
        
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray4
        addedSubwiew()
        setupConstrain()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Add Subwiew
    func addedSubwiew() {
        addSubview(myLabel)
        addSubview(nameLabel)
        addSubview(photoImageView)
        addSubview(buttonProfile)
        addSubview(statusTextField)
    }
    
    //MARK: - Constrain
    func setupConstrain() {
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            photoImageView.widthAnchor.constraint(equalToConstant: 100),
            photoImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 132),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            myLabel.topAnchor.constraint(equalTo: nameLabel.safeAreaLayoutGuide.topAnchor, constant: 30),
            myLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 132),
            myLabel.widthAnchor.constraint(equalToConstant: 100),
            myLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            statusTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            statusTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 132),
            statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            buttonProfile.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            self.buttonProfile.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.buttonProfile.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.buttonProfile.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    //MARK: - Actions
    
    @objc private func pressedButton() {
        myLabel.text = statusText
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
}

