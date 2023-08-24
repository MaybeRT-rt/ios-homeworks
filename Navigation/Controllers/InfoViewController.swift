//
//  InfoViewController.swift
//  Navigation
//
//  Created by Liz-Mary on 06.04.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var orbitalPeriodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var button: CustomButton = {
        let buttonLog = CustomButton(title: "Alert", titleColor: .white) { [weak self] in
            self?.pressButtonAlert()
        }
        return buttonLog
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupButton()
        fetchToDo()
        fetchPlanet()
    }

    
    func setupButton() {
        self.view.addSubview(button)
        self.view.addSubview(titleLabel)
        self.view.addSubview(orbitalPeriodLabel)
        
        NSLayoutConstraint.activate([
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        
        orbitalPeriodLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        orbitalPeriodLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
        
        self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -400),
        self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
        self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        self.button.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }
    
    func fetchToDo() {
        let urlString = "https://jsonplaceholder.typicode.com/todos/1"
        if let url = URL(string: urlString) {
            let appConfigurations = AppConfigurations(url: url)
            NetworkService.request(for: appConfigurations) { result in
                switch result {
                case .success(let json):
                    if let title = json["title"] as? String {
                        DispatchQueue.main.async {
                            self.titleLabel.text = title
                        }
                    }
                case .failure(let error):
                    print("Request error:", error)
                }
            }
        }
    }
    
    func fetchPlanet() {
        let urlString = "https://swapi.dev/api/planets/1"
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    print("Request error:", error)
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let planet = try decoder.decode(Planet.self, from: data)
                        DispatchQueue.main.async {
                            self.orbitalPeriodLabel.text = "Orbital Period: \(planet.orbitalPeriod)"
                        }
                    } catch {
                        print("JSON decoding error:", error)
                    }
                }
            }
            task.resume()
        }
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
