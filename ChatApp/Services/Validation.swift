//
//  Validation.swift
//  ChatApp
//
//  Created by Сергей Иванов on 04.02.2021.
//

import UIKit


class Validation {
    static func isFilled(fullname: String?, about: String?) -> Bool {
        guard let fullname = fullname,
              let about = about,
              fullname != "",
              about != "" else {
            return false
        }
        return true
    }
    
    static func isFilled(image: UIImage) -> Bool {
        if image == UIImage(systemName: "photo") {
            return false
        }
        return true
    }
    
    static func isConfirmedPassworld(password: String?, confirmedPassword: String?) -> Bool {
        guard let password = password, let confirmedPassword = confirmedPassword else {
            return false
        }
        if password != confirmedPassword {
            return false
        }
        return true
    }
    
    static func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
