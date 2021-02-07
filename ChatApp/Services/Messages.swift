//
//  Messages.swift
//  ChatApp
//
//  Created by Сергей Иванов on 30.01.2021.
//

import UIKit

class Messages {
    static func show(target: UIViewController, title: String = "", message: String, handler: (() -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) {_ in
            handler?()
        }
        ac.addAction(action)
        target.present(ac, animated: true, completion: nil)
    }
    
    static func showWidthCancel(target: UIViewController, title: String = "", message: String, handler: (() -> Void)?, cancel: (() -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) {_ in
            handler?()
        }
        let actionС = UIAlertAction(title: "Отменить", style: .cancel) {_ in
            cancel?()
        }
        ac.addAction(action)
        ac.addAction(actionС)
        target.present(ac, animated: true, completion: nil)
    }
}
