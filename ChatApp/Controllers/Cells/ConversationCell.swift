//
//  ConversationCell.swift
//  ChatApp
//
//  Created by Сергей Иванов on 25.01.2021.
//

import UIKit

class ConversationCell: UICollectionViewCell {
    static let reuseIdentifier = "conversation-cell"
    var imageView = UIImageView()
    var fullnameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        addSubview(fullnameLabel)
        fullnameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullnameLabel.font = fullnameLabel.font.withSize(14)
        NSLayoutConstraint.activate([
            fullnameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            fullnameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            fullnameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            fullnameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configure(imageName: String, fullname: String) {
        self.imageView.image = UIImage(named: imageName)
        self.fullnameLabel.text = fullname
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
