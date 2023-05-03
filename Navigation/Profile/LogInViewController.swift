//
//  LogInViewController.swift
//  Navigation
//
//  Created by Liz-Mary on 22.04.2023.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentV = UIView()
        contentV.translatesAutoresizingMaskIntoConstraints = false
        return contentV
    }()
    
    // для textfield
    private lazy var tFView: UIView = {
        let textFieldView = UIView()
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        return textFieldView
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 10
        stack.layer.borderWidth = 0.5
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
       
        return stack
        
    }()
    
    let logoImageView: UIImageView = {
        var logo = UIImageView()
        logo.image = UIImage(named: "logo.png")
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        return logo
        
    }()
    
    private lazy var loginTextField: UITextField = {
        var loginTF = UITextField()
        loginTF.placeholder = "Email or phone"
        loginTF.borderStyle = UITextField.BorderStyle.none
        loginTF.layer.backgroundColor = UIColor.systemGray6.cgColor
        loginTF.layer.borderColor = UIColor.lightGray.cgColor
        loginTF.layer.borderWidth = 0.5
        loginTF.minimumFontSize = 15
        loginTF.autocapitalizationType = .none
        loginTF.textColor = UIColor.black
        loginTF.clearButtonMode = UITextField.ViewMode.whileEditing
        
        loginTF.delegate = self
        loginTF.translatesAutoresizingMaskIntoConstraints = false
        
        
        return loginTF
    }()
    
    private lazy var passTextField: UITextField = {
        var passTF = UITextField()
        passTF.placeholder = "Password"
        passTF.borderStyle = UITextField.BorderStyle.none
        passTF.layer.backgroundColor = UIColor.systemGray6.cgColor
        passTF.layer.borderColor = UIColor.lightGray.cgColor
        passTF.layer.borderWidth = 0.5
        passTF.minimumFontSize = 15
        passTF.autocapitalizationType = .none
        passTF.textColor = UIColor.black
        passTF.clearButtonMode = UITextField.ViewMode.whileEditing
        
        passTF.delegate = self
        passTF.isSecureTextEntry = true
        passTF.translatesAutoresizingMaskIntoConstraints = false
        
        
        return passTF
    }()
    
    private lazy var buttonLogin: UIButton = {
        let buttonLog = UIButton()
        buttonLog.setBackgroundImage(UIImage(named: "blue_pixel.png"), for: .normal)
        buttonLog.layer.masksToBounds = true
        buttonLog.layer.cornerRadius = 10.0
        buttonLog.setTitle("Log In", for: .normal)
        buttonLog.setTitleColor(.white, for: .normal)
        buttonLog.translatesAutoresizingMaskIntoConstraints = false
        buttonLog.addTarget(self, action: #selector(pressButtonLogin), for: .touchUpInside)
        
        return buttonLog
        
    }()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addedSubwiew()
        setupConstrain()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    

    func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
    }
    
    func addedSubwiew() {
        contentView.addSubview(logoImageView)
        stackView.addSubview(loginTextField)
        stackView.addSubview(passTextField)
        stackView.addSubview(tFView)
        contentView.addSubview(stackView)
        contentView.addSubview(buttonLogin)
        scrollView.addSubview(contentView)
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        
    }
    
    //MARK: - Constraints
    func setupConstrain() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
       
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            loginTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            loginTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            
            tFView.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 0),
            tFView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tFView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tFView.heightAnchor.constraint(equalToConstant: 0),
            
            stackView.topAnchor.constraint(equalTo: loginTextField.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: passTextField.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            passTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 0),
            passTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            passTextField.heightAnchor.constraint(equalToConstant: 50),
            
            buttonLogin.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 16),
            buttonLogin.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonLogin.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            buttonLogin.heightAnchor.constraint(equalToConstant: 50),
            buttonLogin.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
        if scrollView.contentInset.bottom == 0 {
            scrollView.contentInset.bottom += keyboardHeight + 50
        }
    }
    
    //MARK: - Actions
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    @objc private func pressButtonLogin() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
}


