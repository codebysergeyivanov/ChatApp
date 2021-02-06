//
//  LoginVC.swift
//  ChatApp
//
//  Created by Сергей Иванов on 23.01.2021.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {
    var topSV: UIStackView!
    var bottomSV: UIStackView!
    let headerTitle = UILabel(text: "Welcome back!")
    let googleLabel = UILabel(text: "Login with")
    let googleButton = UIButton(title: "Google", titleColor: UIColor.darkText, backgroundColor: .colorLight, isShadow: true)
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let emailTF = TFWithBottemBorderLine(placeholder: "Email")
    let passwordTF = TFWithBottemBorderLine(placeholder: "Password")
    let loginButton = UIButton(title: "Login", titleColor: UIColor.white, backgroundColor: .colorDark, isShadow: false)
    let singUpButton = UIButton(title: "Sign Up", titleColor: .systemPink, backgroundColor: .colorLight, isShadow: false)
    
    var delegate: NavigationDeleagate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        singUpButton.addTarget(self, action: #selector(signup), for: .touchUpInside)
    }
    
    @objc func login() {
        let email = emailTF.text
        let password = passwordTF.text
        
        guard Validation.isValidEmail(email) else {
            Messages.show(target: self, title: "Ошибка", message: FormError.emailNotCorrect.localizedDescription, handler: nil)
            return
        }
        
        AuthService.shared.signIn(target: self, email: email!, password: password!) {
            if let user = Auth.auth().currentUser {
                FirestoreService.shared.getUser(user: user) {
                    muser in
                    if let muser = muser {
                        self.dismiss(animated: true) { [unowned self] in
                            self.delegate?.goToTabVC(user: muser)
                        }
                    } else {
                        self.dismiss(animated: true) { [unowned self] in
                            self.delegate?.goToProfileVC(user: user, isFullScreen: true)
                        }
                    }
                }
            }
        }
    }
    
    @objc func signup() {
        self.dismiss(animated: true) { [unowned self] in
            self.delegate?.goToSignUpVC()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - Setup constraints
extension LoginVC {
    func addSubviews() {
        view.addSubview(headerTitle)
        
        // let googleForm = ButtonForm(label: googleLabel, button: googleButton)
        let emailSV = UIStackView(arrangedSubviews: [emailLabel, emailTF], axis: .vertical, spacing: 10, alignment: .fill)
        let passwordSV = UIStackView(arrangedSubviews: [passwordLabel, passwordTF], axis: .vertical, spacing: 10, alignment: .fill)
        
        topSV = UIStackView(arrangedSubviews: [
            // googleForm,
            // UILabel(text: "or"),
            emailSV,
            passwordSV,
            loginButton
        ], axis: .vertical, spacing: 40, alignment: .fill)
        view.addSubview(topSV)
        
        let singUpLabel = UILabel(text: "Need an account?")
        
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        bottomSV = UIStackView(arrangedSubviews: [
            singUpLabel,
            singUpButton,
            spacer,
        ], axis: .horizontal, spacing: 10, alignment: .center)
        bottomSV.distribution = .fill
        view.addSubview(bottomSV)
    }
    
    func setupConstraints() {
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            headerTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        topSV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topSV.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 100),
            topSV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            topSV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        bottomSV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomSV.topAnchor.constraint(equalTo: topSV.bottomAnchor, constant: 40),
            bottomSV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            bottomSV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

import SwiftUI
struct LoginVCPreview: PreviewProvider{
   
    static var previews: some View{
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
 
        typealias UIViewControllerType = LoginVC
        
        func makeUIViewController(context: Self.Context) -> Self.UIViewControllerType {
            return LoginVC()
        }

        func updateUIViewController(_ uiViewController: LoginVC, context: UIViewControllerRepresentableContext<LoginVCPreview.ContainerView>) {}
    }
}

