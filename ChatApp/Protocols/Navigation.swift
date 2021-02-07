//
//  navigation.swift
//  ChatApp
//
//  Created by Сергей Иванов on 30.01.2021.
//

import Foundation
import FirebaseAuth

protocol NavigationDelegate {
    func goToProfileVC(user: User, isFullScreen: Bool) -> Void
    func goToTabVC(user: MUser) -> Void
    func goToLoginVC() -> Void
    func goToSignUpVC() -> Void
}

protocol NavigationPeopleDelegate {
    func startChat(message: String, receivedId: String) -> Void
}
