//
//  Auth.swift
//  ChatApp
//
//  Created by Сергей Иванов on 30.01.2021.
//

import UIKit
import Firebase

class AuthService {
    static let shared = AuthService()
    private init() {}
    
    func createUser(target: UIViewController, email: String, password: String, complition: @escaping () -> ()?) {
        Auth.auth().createUser(withEmail: email, password: password) { [unowned target] authResult, error in
            guard let user = authResult?.user, error == nil else {
                Messages.show(target: target, title: "Ошибка", message: error!.localizedDescription, handler: nil)
                print(error!.localizedDescription)
                return
            }
            print("\(user.email!) created")
            complition()
        }
    }
}
