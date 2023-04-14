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
    
    let myLabel = UILabel(frame: CGRect(x: 130, y: 74, width: 226.00, height: 20))
    
    
    //MARK: - Name Label
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.frame = CGRect(x: 130, y: 0, width: 100, height: 100)
        name.text = "No name"
        name.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        name.textColor = .black

        return name
        
    }()
    
    //MARK: - ImageView Avatar
    
    let photoImageView: UIImageView = {
        let photo = UIImageView()
        photo.frame = CGRect(x: 16.0, y: 32, width: 100, height: 100)
        photo.layer.cornerRadius = 50
        photo.layer.borderWidth = 3
        photo.layer.borderColor = UIColor.white.cgColor
        photo.clipsToBounds = true
        photo.image = UIImage(named: "bich2")
        
        return photo
        
    }()
    
    //MARK: - Status
    
    private var statusText: String = ""
    
    
    //MARK: - TextField Status
    
    private lazy var statusTextField: UITextField = {
        var myTextField = UITextField()
        myTextField = UITextField(frame: CGRect(x: 130, y: 116, width: 230.00, height: 40))
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
        myTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        addSubview(myTextField)
        
        return myTextField
    }()
    
    //MARK: - Button
    
    private lazy var buttonProfile: UIButton = {
        let button = UIButton()
        buttonProfile = UIButton(frame: CGRect(x: 166, y: 264, width: 200.00, height: 50))
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = CGFloat(4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        addSubview(buttonProfile)
        
        return button
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray4
        addSubview(myLabel)
        addSubview(nameLabel)
        addSubview(photoImageView)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func viewedPhoto() {
//
//        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
//    }
    
    func setupButton() {
        addSubview(buttonProfile)
        
        self.buttonProfile.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 34).isActive = true
        self.buttonProfile.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        self.buttonProfile.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        self.buttonProfile.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func pressedButton() {
        myLabel.text = statusText
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
}

