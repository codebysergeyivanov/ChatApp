//
//  FormError.swift
//  ChatApp
//
//  Created by Сергей Иванов on 05.02.2021.
//

import Foundation


enum FormError {
    case notFilled
    case photoNotExist
    case emailNotCorrect
    case passwordNotConfirmed
}

extension FormError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Фото профиля не установленно", comment: "")
        case .emailNotCorrect:
            return NSLocalizedString("Введен некорректный e-mail", comment: "")
        case .passwordNotConfirmed:
            return NSLocalizedString("Пароли не совпадают", comment: "")
        }
    }
}
