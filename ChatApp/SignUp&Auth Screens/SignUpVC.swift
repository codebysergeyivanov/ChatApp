//
//  SingUpVC.swift
//  ChatApp
//
//  Created by Сергей Иванов on 16.01.2021.
//

import UIKit

class SignUpVC: UIViewController {
    let headerTitle = UILabel(text: "Good to see you!")
    var groupButtonView: UIStackView!
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let confirmedPasswordLabel = UILabel(text: "Confirm password")
    let emailTF = TFWithBottemBorderLine(placeholder: "Email")
    let passwordTF = TFWithBottemBorderLine(placeholder: "Password")
    let confirmedPasswordTF = TFWithBottemBorderLine(placeholder: "Confirm password")
    let singUpButton = UIButton(title: "Sing Up", titleColor: UIColor.white, backgroundColor: .colorDark, isShadow: false)
    let loginButton = UIButton(title: "Login", titleColor: .systemPink, backgroundColor: .colorLight, isShadow: false)
    
    var delegate: NavigationDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        singUpButton.addTarget(self, action: #selector(registration), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    @objc func registration() {
        let email = emailTF.text
        let password = passwordTF.text
        let confirmedPassword = confirmedPasswordTF.text
        
        guard Validation.isValidEmail(email) else {
            Messages.show(target: self, title: "Ошибка", message: FormError.emailNotCorrect.localizedDescription, handler: nil)
            return
        }
        guard Validation.isConfirmedPassworld(password: password, confirmedPassword: confirmedPassword) else {
            Messages.show(target: self, title: "Ошибка", message: FormError.passwordNotConfirmed.localizedDescription, handler: nil)
            return
        }
        
        AuthService.shared.createUser(target: self, email: email!, password: password!) {
            [unowned self] user in
            Messages.show(target: self, message: "Вы успешно зарегистрированы") { [unowned self] in
                self.dismiss(animated: true) { [unowned self] in
                    self.delegate?.goToProfileVC(user: user, isFullScreen: false)
                }
            }
        }
    }
    
    @objc func login() {
        self.dismiss(animated: true) { [unowned self] in
            self.delegate?.goToLoginVC()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - Setup constraints
extension SignUpVC {
    func addSubviews() {
        view.addSubview(headerTitle)
        
        let emailSV = UIStackView(arrangedSubviews: [emailLabel, emailTF], axis: .vertical, spacing: 10, alignment: .fill)
        let passwordSV = UIStackView(arrangedSubviews: [passwordLabel, passwordTF], axis: .vertical, spacing: 10, alignment: .fill)
        let confirmedPasswordSV = UIStackView(arrangedSubviews: [confirmedPasswordLabel, confirmedPasswordTF], axis: .vertical, spacing: 10, alignment: .fill)
        let spacerView = UIView()
        UIView().setContentHuggingPriority(.defaultLow, for: .horizontal)
        let loginSV  = UIStackView(arrangedSubviews: [
          UILabel(text: "Alredy onboard?"),
          loginButton,
          spacerView
        ], axis: .horizontal, spacing: 10, alignment: .center)
        loginSV.distribution = .fill
        
        groupButtonView = UIStackView(arrangedSubviews: [emailSV, passwordSV, confirmedPasswordSV, singUpButton, loginSV], axis: .vertical, spacing: 40, alignment: .fill)
        view.addSubview(groupButtonView)
    }
    
    func setupConstraints() {
        singUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            headerTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        groupButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupButtonView.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 100),
            groupButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            groupButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}


import SwiftUI
struct SingUpVCPreview: PreviewProvider{
   
    static var previews: some View{
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
 
        typealias UIViewControllerType = SignUpVC
        
        func makeUIViewController(context: Self.Context) -> Self.UIViewControllerType {
            return SignUpVC()
        }

        func updateUIViewController(_ uiViewController: SignUpVC, context: UIViewControllerRepresentableContext<SingUpVCPreview.ContainerView>) {}
    }
}
