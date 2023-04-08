//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Liz-Mary on 06.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
 
    let myLabel = UILabel(frame: CGRect(x: 150, y: 120, width: 200, height: 21))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewedPhoto()
        textFieldViewed()
    }
}

extension ProfileViewController: UITextFieldDelegate {
    
    func viewedPhoto() {
        let photoImageView = UIImageView(frame: CGRect(x: 30, y: 100, width: 100, height: 100))
        photoImageView.layer.cornerRadius = 50
        photoImageView.clipsToBounds = true
        photoImageView.image = UIImage(named: "bich2")
        
        view.addSubview(photoImageView)
    }
    
    func textFieldViewed() {
        let myTextField: UITextField = UITextField(frame: CGRect(x: 150, y: 150, width: 200.00, height: 30.00));
        myTextField.placeholder = "Place your status"
        myTextField.text = ""
        myTextField.borderStyle = UITextField.BorderStyle.line
        myTextField.backgroundColor = UIColor.white
        myTextField.textColor = UIColor.blue
        myTextField.delegate = self
        self.view.addSubview(myTextField)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        myLabel.text = ""
        self.view.addSubview(myLabel)
        myLabel.text = newText
        
        return true
    }
}



