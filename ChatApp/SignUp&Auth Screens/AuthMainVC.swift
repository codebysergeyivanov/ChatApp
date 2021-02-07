//
//  AuthMainVC.swift
//  ChatApp
//
//  Created by Сергей Иванов on 15.01.2021.
//

import UIKit
import FirebaseAuth

class AuthMainVC: UIViewController {
    let logoLabel = UILabel(text: "Chat App")
    var groupButtonView: UIStackView!
    
    let googleLabel = UILabel(text: "Get started with")
    let googleButton = UIButton(title: "Google", titleColor: UIColor.darkText, backgroundColor: .colorLight, isShadow: true)
    
    let emailLabel = UILabel(text: "Or sign up with")
    let emailButton = UIButton(title: "Email", titleColor: UIColor.white, backgroundColor: .colorDark, isShadow: false)
    
    let loginLabel = UILabel(text: "Already onboard?")
    let loginButton = UIButton(title: "Login", titleColor: .systemPink, backgroundColor: .colorLight, isShadow: true)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
        addSubviews()
        setupConstraints()
        
        emailButton.addTarget(self, action: #selector(signup), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    @objc func signup() {
        goToSignUpVC()
    }
    
    @objc func login() {
        goToLoginVC()
    }
    
    private func addSubviews() {
        // let googleForm = ButtonForm(label: googleLabel, button: googleButton)
        let emailForm = ButtonForm(label: emailLabel, button: emailButton)
        let loginForm = ButtonForm(label: loginLabel, button: loginButton)
        
        groupButtonView = UIStackView(arrangedSubviews: [emailForm, loginForm], axis: .vertical, spacing: 50, alignment: .fill)
        
        view.addSubview(logoLabel)
        view.addSubview(groupButtonView)
    }
}

extension AuthMainVC: NavigationDelegate {    
    func goToTabVC(user: MUser) {
        UIApplication.shared.windows.first?.rootViewController = TabVC(user: user)
    }
    
    func goToProfileVC(user: User, isFullScreen: Bool) {
        let profileVC = ProfileVC(user: user)
        if isFullScreen {
            profileVC.modalPresentationStyle = .fullScreen
        }
        self.present(profileVC, animated: true, completion: nil)
    }
    
    func goToLoginVC() {
        let loginVC = LoginVC()
        loginVC.delegate = self
        present(loginVC, animated: true, completion: nil)
    }
    
    func goToSignUpVC() {
        let signUpVC = SignUpVC()
        signUpVC.delegate = self
        present(signUpVC, animated: true, completion: nil)
    }
}

// MARK: - Setup constraints
extension AuthMainVC {
    func setupConstraints() {
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        groupButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupButtonView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 100),
            groupButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            groupButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}


import SwiftUI
struct MainPreview: PreviewProvider{
   
    static var previews: some View{
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
 
        typealias UIViewControllerType = AuthMainVC
        
        func makeUIViewController(context: Self.Context) -> Self.UIViewControllerType {
            return AuthMainVC()
        }

        func updateUIViewController(_ uiViewController: AuthMainVC, context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) {}
    }
}
