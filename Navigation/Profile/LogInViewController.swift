//
//  LogInViewController.swift
//  Navigation
//
//  Created by Liz-Mary on 22.04.2023.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    var loginDelegate: LoginViewControllerDelegate? = LoginInspector()
    
    var loginFactory: LoginFactory?
    private var loginInspector: LoginInspector?
    
    private var currentUser: User?
    
    private let pwdBruteForce = PasswordBruteForce()
    
    private lazy var loginManager = LoginManager()
    
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
    
    private lazy var buttonLogin: CustomButton = {
        let buttonLog = CustomButton(title: "Log In", titleColor: .white) { [weak self] in
            self?.pressButtonLogin()
        }
        return buttonLog
    }()
    
    private lazy var buttonBruteForce: CustomButton = {
        let buttonLog = CustomButton(title: "BruteForce", titleColor: .white) { [weak self] in
            self?.bruteforcePassword()
        }
        return buttonLog
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addedSubwiew()
        setupConstrain()
        
        if let loginFactory = loginFactory {
            let loginInspector = loginFactory.makeLoginInspector()
            loginDelegate = loginInspector
        }
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
        scrollView.addSubview(buttonBruteForce)
        scrollView.addSubview(activityIndicator)
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
            
            buttonBruteForce.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 16),
            buttonBruteForce.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonBruteForce.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            buttonBruteForce.heightAnchor.constraint(equalToConstant: 50),
            
            activityIndicator.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 15),
            activityIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
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
    
    private func setupDefaultValues() {
        let defaultLogin = "adm"
        let defaultPassword = "a123"
        
        if loginTextField.text?.isEmpty ?? true {
            loginTextField.text = defaultLogin
        }
        
        if passTextField.text?.isEmpty ?? true {
            passTextField.text = defaultPassword
        }
    }
    
    @objc private func bruteforcePassword() {
        guard let pwdCheck = passTextField.text, !pwdCheck.isEmpty else {
            self.view.makeToast("The password field is empty")
            return
        }
        
        buttonBruteForce.isEnabled = false
        
        activityIndicator.startAnimating()
        DispatchQueue.global().async { [weak self] in
            self?.pwdBruteForce.bruteForce(passwordToCrack: pwdCheck) { [weak self] pwdCheck in
                DispatchQueue.main.async {
                    self?.buttonBruteForce.isEnabled = true
                    self?.activityIndicator.stopAnimating()
                    self?.passTextField.isSecureTextEntry = false
                    self?.passTextField.text = pwdCheck
                    
                }
            }
        }
    }
    
    
    @objc private func pressButtonLogin() {
        guard let delegate = loginDelegate else {
            return
        }
        
        let login = loginTextField.text ?? "adm"
        let password = passTextField.text ?? "a123"
        setupDefaultValues()
        self.passTextField.isSecureTextEntry = true
        
        let userService: UserService = TestUserService(user: User(login: "adm", fullName: "Test User", avatar: UIImage(named: "7.png") ?? UIImage(named: "avatar.png")!, status: "Testing"))
        
        LoginManager.login(
            withLogin: login,
            password: password,
            delegate: delegate,
            navigationController: self.navigationController,
            userService: userService
        ) { [weak self] result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    let profileVC = ProfileViewController()
                    profileVC.user = user
                    self?.navigationController?.pushViewController(profileVC, animated: true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showErrorAlert(error: error)
                }
            }
        }
    }
    
    private func showErrorAlert(error: AppError) {
        var errorMessage = ""
        switch error {
        case .loginFailed:
            errorMessage = "Неверный логин или пароль"
        case .emptyLoginField:
            errorMessage = "Поле логина не заполнено"
        case .emptyPasswordField:
            errorMessage = "Поле пароля не заполнено"
        case .bruteForceError:
            errorMessage = "Произошла ошибка перебора пароля"
        case .userServiceError(let message):
            errorMessage = "Ошибка сервиса пользователя: \(message)"
        case .unknownError:
            errorMessage = "Произошла неизвестная ошибка"
        }
        
        let alert = UIAlertController(title: "Ошибка", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
