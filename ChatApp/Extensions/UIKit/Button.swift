//
//  Button.swift
//  ChatApp
//
//  Created by Сергей Иванов on 15.01.2021.
//

import UIKit

extension UIButton {
    convenience init(title: String, titleColor: UIColor, backgroundColor: UIColor, cornerRadius: CGFloat = 4.0, isShadow: Bool = false) {
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        
        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.34
            self.layer.shadowOffset = CGSize(width: 0, height: 5)
            self.layer.shadowRadius = 6
        }
    }
}
