//
//  navigation.swift
//  ChatApp
//
//  Created by Сергей Иванов on 30.01.2021.
//

import Foundation
import FirebaseAuth

protocol NavigationDeleagate {
    func goToProfileVC(user: User, isFullScreen: Bool) -> Void
    func goToTabVC(user: MUser) -> Void
    func goToLoginVC() -> Void
    func goToSignUpVC() -> Void
}
