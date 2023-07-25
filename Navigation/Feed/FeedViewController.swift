//
//  FeedViewController.swift
//  Navigation
//
//  Created by Liz-Mary on 06.04.2023.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    private var viewModelFeed: FeedViewModel
    
    let containerView = UIView()
    
    
    init(viewModelFeed: FeedViewModel) {
        self.viewModelFeed = viewModelFeed
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
    
    private lazy var button1 = CustomButton(title: "Open post", titleColor: .white) { [weak self] in
        self?.viewModelFeed.button1Tapped()
        }
    
    private lazy var button2 = CustomButton(title: "Open post", titleColor: .white) { [weak self] in
        self?.viewModelFeed.button2Tapped()
        }
    
    private lazy var buttonCheck = CustomButton(title: "Проверить", titleColor: .white) { [weak self] in
        self?.viewModelFeed.checkButtonTapped(word: self?.textField.text ?? "")
        }
    
    private lazy var textField: UITextField = {
        let checkTF = UITextField()
        checkTF.translatesAutoresizingMaskIntoConstraints = false
        checkTF.borderStyle = .roundedRect
        checkTF.placeholder = "Введите слово"
        
        return checkTF
    }()
    
    private lazy var buttonView: UIView = {
        let buttonView = UIView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        return buttonView
    }()
    
    private var checkWord: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addedSubwiew()
        setupConstraint()
        viewModelFeed = FeedViewModel()
        bindViewModel()
    }
    
    //MARK: - Add Subwiew
    func addedSubwiew() {
        view.addSubview(textField)
        // view.addSubview(checkWord)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(checkWord)
        stackView.addArrangedSubview(buttonCheck)
        stackView.addArrangedSubview(buttonView)
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
    }
    
    //MARK: - Add Constraint StackView
    private func setupConstraint() {
        
        NSLayoutConstraint.activate([
            
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            
            checkWord.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            checkWord.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            checkWord.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            checkWord.widthAnchor.constraint(equalToConstant: 100),
            
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            self.buttonView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.buttonView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.buttonView.heightAnchor.constraint(equalToConstant: 100),
            
            self.buttonCheck.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.buttonCheck.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.buttonCheck.heightAnchor.constraint(equalToConstant: 50),
            
            self.button1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.button1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.button1.heightAnchor.constraint(equalToConstant: 50),
            
            self.button2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.button2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.button2.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func bindViewModel() {
        viewModelFeed.wordCheckResult = { [weak self] result in
            self?.checkWord.text = result.isCorrect ? "Верно" : "Неверно"
            self?.checkWord.textColor = result.isCorrect ? .green : .red
        }
        
        viewModelFeed.navigateToPost = { [weak self] title in
            let postViewController = PostViewController()
            postViewController.titlePost = title
            self?.navigationController?.pushViewController(postViewController, animated: true)
        }
    }
}
 
