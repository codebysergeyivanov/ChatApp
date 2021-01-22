//
//  TFoneBorderLine.swift
//  ChatApp
//
//  Created by Сергей Иванов on 22.01.2021.
//

import UIKit


class TFWithBottemBorderLine: UITextField {
    convenience init(placeholder: String = "") {
        self.init()
        
        self.borderStyle = .none
        
        let bottomView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomView.backgroundColor = .lightGray
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomView)
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}
