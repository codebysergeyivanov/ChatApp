//
//  Input.swift
//  ChatApp
//
//  Created by Сергей Иванов on 27.01.2021.
//

import UIKit

class Input: UITextField {
    let button = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9136453271, green: 0.9137768149, blue: 0.9136165977, alpha: 0.5)
        attributedPlaceholder = NSAttributedString(string: "Send a message",
                                                   attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)])
        layer.cornerRadius = 18
        layer.masksToBounds = true
        
        let image = UIImage(systemName: "smiley")
        let imageView = UIImageView(image: image)
        imageView.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        leftView = imageView
        leftView?.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        leftViewMode = .always

        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        rightView = button
        rightView?.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        rightViewMode = .always
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect
    {
        var textRect = super.textRect(forBounds: bounds)
        textRect.origin.x -= -10
        return textRect
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.textRect(forBounds: bounds)
        textRect.origin.x -= -10
        return textRect
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 15
        return rect
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x += -15
        return rect
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
