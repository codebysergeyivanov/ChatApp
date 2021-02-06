//
//  Auth.swift
//  ChatApp
//
//  Created by Сергей Иванов on 30.01.2021.
//

import UIKit
import FirebaseAuth

class AuthService {
    static let shared = AuthService()
    private init() {}
    
    func createUser(target: UIViewController, email: String, password: String, complition: @escaping (_ user: User) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { [unowned target] authResult, error in
            guard let user = authResult?.user, error == nil else {
                Messages.show(target: target, title: "Ошибка", message: error!.localizedDescription, handler: nil)
                print(error!.localizedDescription)
                return
            }
            print("\(user.email!) created")
            complition(user)
        }
    }
    
    func signIn(target: UIViewController, email: String, password: String, complition: @escaping () -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { [unowned target] authResult, error in
            guard let user = authResult?.user, error == nil else {
                Messages.show(target: target, title: "Ошибка", message: error!.localizedDescription, handler: nil)
                print(error!.localizedDescription)
                return
            }
            print("\(user.email!) sign in")
            complition()
        }
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UIApplication.shared.windows.first?.rootViewController = AuthMainVC()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
