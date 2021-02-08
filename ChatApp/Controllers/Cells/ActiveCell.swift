//
//  ActiveCell.swift
//  ChatApp
//
//  Created by Сергей Иванов on 25.01.2021.
//

import UIKit
import SDWebImage

class ActiveCell: UICollectionViewCell {
    static let reuseIdentifier = "active-cell"
    static let nib = UINib(nibName: "ActiveCell", bundle: nil)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(avatarImageStringURL: String, fullname: String, lastMessage: String) {
        self.imageView?.sd_setImage(with: URL(string: avatarImageStringURL), completed: nil)
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        self.fullnameLabel?.text = fullname
        self.lastMessageLabel?.text = lastMessage
    }
}
