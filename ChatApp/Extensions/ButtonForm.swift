//
//  From.swift
//  ChatApp
//
//  Created by Сергей Иванов on 15.01.2021.
//

import UIKit

class ButtonForm: UIView {
    init(label: UILabel, button: UIButton) {
        super.init(frame: .zero)
        setupConstraints(label: label, button: button)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup constraints
extension ButtonForm {
    func setupConstraints(label: UILabel, button: UIButton) {
        self.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        addSubview(button)
        
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
    }
}
