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
    
    let logoImageView: UIImageView = {
        var logo = UIImageView()
        logo.image = UIImage(named: "logo.png")
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        return logo
        
    }()
    
    private lazy var loginTextField: UITextField = {
        var loginTF = UITextField()
        loginTF.placeholder = " Email or phone"
        loginTF.borderStyle = UITextField.BorderStyle.none
        loginTF.layer.backgroundColor = UIColor.systemGray6.cgColor
        loginTF.layer.borderColor = UIColor.systemGray4.cgColor
        loginTF.layer.borderWidth = 0.5
        loginTF.layer.cornerRadius = 10
        loginTF.minimumFontSize = 15
        loginTF.autocapitalizationType = .none
        loginTF.textColor = UIColor.black
        loginTF.clearButtonMode = UITextField.ViewMode.whileEditing
        
        loginTF.delegate = self
        loginTF.translatesAutoresizingMaskIntoConstraints = false
        // loginTF.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        return loginTF
    }()
    
    private lazy var passTextField: UITextField = {
        var passTF = UITextField()
        passTF.placeholder = " Password"
        passTF.borderStyle = UITextField.BorderStyle.none
        passTF.layer.backgroundColor = UIColor.systemGray6.cgColor
        passTF.layer.borderWidth = 0.5
        passTF.layer.borderColor = UIColor.systemGray4.cgColor
        passTF.layer.cornerRadius = 10
        passTF.minimumFontSize = 15
        passTF.autocapitalizationType = .none
        passTF.textColor = UIColor.black
        passTF.clearButtonMode = UITextField.ViewMode.whileEditing
        
        passTF.delegate = self
        passTF.isSecureTextEntry = true
        passTF.translatesAutoresizingMaskIntoConstraints = false
        // loginTF.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        return passTF
    }()
    
    private lazy var buttonLogin: UIButton = {
        let buttonLog = UIButton()
        //buttonLog.backgroundColor = .systemBlue
        buttonLog.setBackgroundImage(UIImage(named: "blue_pixel.png"), for: .normal)
        buttonLog.layer.cornerRadius = 10
        buttonLog.layer.shadowOffset = CGSize(width: 4, height: 4)
        buttonLog.layer.shadowRadius = CGFloat(4)
        buttonLog.layer.shadowOpacity = 0.7
        buttonLog.setTitle("Log In", for: .normal)
        buttonLog.setTitleColor(.white, for: .normal)
        buttonLog.translatesAutoresizingMaskIntoConstraints = false
        buttonLog.addTarget(self, action: #selector(pressButtonLogin), for: .touchUpInside)
        
        return buttonLog
        
    }()
    
    
    //MARK: - Life
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addedSubwiew()
        setupConstrain()
        //pressButtonLogi
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
        contentView.addSubview(loginTextField)
        contentView.addSubview(passTextField)
        contentView.addSubview(buttonLogin)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
    }
    
    //MARK: - Constraints
    func setupConstrain() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            loginTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            loginTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 0),
            passTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            passTextField.heightAnchor.constraint(equalToConstant: 50),
            
            buttonLogin.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 16),
            buttonLogin.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonLogin.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            buttonLogin.heightAnchor.constraint(equalToConstant: 50),
            buttonLogin.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
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
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    
    @objc private func pressButtonLogin() {
        
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }

    
}

