//
//  WaitingCell.swift
//  ChatApp
//
//  Created by Сергей Иванов on 25.01.2021.
//

import UIKit
import SDWebImage

class WaitingCell: UICollectionViewCell {
    static let reuseIdentifier = "waiting-cell"
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
    
    func configure(avatarImageStringURL: String) {
        self.imageView.sd_setImage(with: URL(string: avatarImageStringURL), completed: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
