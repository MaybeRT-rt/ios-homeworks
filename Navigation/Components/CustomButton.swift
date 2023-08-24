//
//  CustomButton.swift
//  Navigation
//
//  Created by Liz-Mary on 02.07.2023.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    var action: (() -> Void)?
    
    init(title: String, titleColor: UIColor, action: @escaping (() -> Void)) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        setBackgroundImage(UIImage(named: "blue_pixel.png"), for: .normal)
        addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        self.action = action
        
        layer.masksToBounds = true
        layer.cornerRadius = 10.0
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedButton() {
        action?()
    }
}
