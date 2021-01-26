//
//  ActiveCell.swift
//  ChatApp
//
//  Created by Сергей Иванов on 25.01.2021.
//

import UIKit

class ActiveCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    static let reuseIdentifier = "active-cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
    
    
    func configure(imageName: String, fullname: String, lastMessage: String) {
        self.imageView?.image = UIImage(named: imageName)
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        self.fullnameLabel?.text = fullname
        self.lastMessageLabel?.text = lastMessage
    }
}
