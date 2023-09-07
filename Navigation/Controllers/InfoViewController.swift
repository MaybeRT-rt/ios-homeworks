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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupButton()
        fetchData()
    }
    
    
    func setupButton() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(orbitalPeriodLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            orbitalPeriodLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orbitalPeriodLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
            
        ])
    }
    
    func fetchData() {
        async {
            do {
                let url1 = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
                let todoItem: TodoItem = try await URLSession.shared.decode(from: url1)
                
                DispatchQueue.main.async {
                    self.titleLabel.text = todoItem.title
                }
                
                let url2 = URL(string: "https://swapi.dev/api/planets/1")!
                let planet: Planet = try await URLSession.shared.decode(from: url2)
                
                DispatchQueue.main.async {
                    self.orbitalPeriodLabel.text = "Orbital Period: \(planet.orbitalPeriod)"
                }
            } catch {
                print("Download error: \(error.localizedDescription)")
            }
        }
    }
}
