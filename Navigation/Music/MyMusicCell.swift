//
//  MyMusicCell.swift
//  Navigation
//
//  Created by Liz-Mary on 19.08.2023.
//

import Foundation
import UIKit

class MyMusicCell: UITableViewCell {
    
    private lazy var musicLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Music"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    
    private lazy var arrow: UIImageView = {
        let arrow = UIImageView()
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.image = UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return arrow
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(musicLabel)
        contentView.addSubview(arrow)
        
        
        NSLayoutConstraint.activate([
            musicLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            musicLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            arrow.centerYAnchor.constraint(equalTo: musicLabel.centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrow.widthAnchor.constraint(equalToConstant: 25),
            arrow.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
}
