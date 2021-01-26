//
//  Header.swift
//  ChatApp
//
//  Created by Сергей Иванов on 25.01.2021.
//

import UIKit

class Header: UICollectionReusableView {
    static let reuseIdentifier = "chatHeader"
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        label.font = UIFont.preferredFont(forTextStyle: .title3)
    }
    
    func configure(text: String) {
        label.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
