//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Liz-Mary on 11.04.2023.
//

import Foundation
import UIKit
import SnapKit

class ProfileHeaderView: UIView, UITextFieldDelegate {
    
    let profileVC = ProfileViewController()
    
    //MARK: - Status Label
    
     lazy var myLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "Тут может быть твой статус"
        statusLabel.textColor = .darkGray
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
    
    // MARK: - Animatioms
    let dimmingView: UIView = {
        let dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.alpha = 0.8
        dimmingView.backgroundColor = .black
        dimmingView.frame = UIScreen.main.bounds
        
        return dimmingView
    }()
    
    
    lazy var buttonCancel: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.alpha = 0
        button.addTarget(self, action: #selector(pressedCancelButton), for: .touchUpInside)
        
        return button
    }()
    
    let fullImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bich2"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.opacity = 0
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        addedSubview()
        setupConstrain()
        tap()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Add Subwiew
    func addedSubview() {
        addSubview(myLabel)
        addSubview(nameLabel)
        addSubview(photoImageView)
        addSubview(buttonProfile)
        addSubview(statusTextField)
        addSubview(buttonCancel)
        addSubview(fullImage)
    }
    
    //MARK: - Constrain
    func setupConstrain() {
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(132)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        myLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(50)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(132)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(80)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(132)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        buttonProfile.snp.makeConstraints { make in
            make.top.equalTo(statusTextField.snp.bottom).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        buttonCancel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(8)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
    }
    
    //MARK: - Actions
    
    @objc private func pressedButton() {
        myLabel.text = statusText
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
    
    func tap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedAwayFunction))
        photoImageView.isUserInteractionEnabled = true
        photoImageView.addGestureRecognizer(tapGesture)
    }
    
    func animateSize(width: CGFloat, height: CGFloat) {
        CATransaction.begin()
        let sizeAnimation = CABasicAnimation(keyPath: "bounds.size")
        sizeAnimation.duration = 2
        sizeAnimation.isRemovedOnCompletion = false
        sizeAnimation.toValue = CGSize(width: width, height: width)
        fullImage.layer.add(sizeAnimation, forKey: "bounds.size")
        fullImage.layer.bounds.size = CGSize(width: width, height: width)
        CATransaction.commit()
    }
    
    @objc func tappedAwayFunction(_ sender: UITapGestureRecognizer) {
        let centerOrigin = superview!.center
        fullImage.translatesAutoresizingMaskIntoConstraints = true
        
        // Сброс фрейма fullImage
        fullImage.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        fullImage.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.fullImage.center = CGPoint(x: centerOrigin.x, y: centerOrigin.y - 20)
            self.animateSize(width: self.superview!.frame.width, height: self.superview!.frame.width)
            
            addedSub()
            
            UIView.animate(withDuration: 0.4, delay: 0, animations: {
                self.buttonCancel.alpha = 1
            })
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveEaseInOut) {
                self.dimmingView.layer.opacity = 0.8
                self.fullImage.layer.cornerRadius = 10
                self.fullImage.layer.opacity = 1
                self.dimmingView.layoutIfNeeded()
            }
            
            UIView.animate(withDuration: 0.2, delay: 0.0) {
                self.buttonCancel.layer.opacity = 1
            }
        }
        
        func addedSub() {
            addSubview(dimmingView)
            addSubview(fullImage)
            addSubview(buttonCancel)
        }
    }
    
    @objc func pressedCancelButton() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveEaseInOut) {
            self.buttonCancel.layer.opacity = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.4, delay: 0) {
                self.dimmingView.layer.opacity = 0.0
                self.fullImage.layer.opacity = 0
                self.dimmingView.layoutIfNeeded()
            }
        }
    }
}
