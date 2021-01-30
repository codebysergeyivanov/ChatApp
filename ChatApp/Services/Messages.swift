//
//  Messages.swift
//  ChatApp
//
//  Created by Сергей Иванов on 30.01.2021.
//

import UIKit

class Messages {
    static func show(target: UIViewController, title: String = "", message: String, handler: (()->())?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) {_ in
            handler?()
        }
        ac.addAction(action)
        target.present(ac, animated: true, completion: nil)
    }
}
