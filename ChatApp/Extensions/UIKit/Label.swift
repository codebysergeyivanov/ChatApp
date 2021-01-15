//
//  Label.swift
//  ChatApp
//
//  Created by Сергей Иванов on 15.01.2021.
//

import UIKit

extension UILabel {
    convenience init(text: String) {
        self.init()
        
        self.text = text
        self.textColor = .black
    }
}
