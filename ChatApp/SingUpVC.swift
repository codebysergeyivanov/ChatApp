//
//  SingUpVC.swift
//  ChatApp
//
//  Created by Сергей Иванов on 16.01.2021.
//

import UIKit

class SingUpVC: UIViewController {
    let headerTitle = UILabel(text: "Good to see you!")
    var groupButtonView: UIStackView!
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let confirmedPasswordLabel = UILabel(text: "Confirm password")
    let emailTF = TFWithBottemBorderLine(placeholder: "Email")
    let passwordTF = TFWithBottemBorderLine(placeholder: "Password")
    let confirmedPasswordTF = TFWithBottemBorderLine(placeholder: "Confirm password")
    let singUpButton = UIButton(title: "Sing Up", titleColor: UIColor.lightText, backgroundColor: .colorDark, isShadow: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
}

// MARK: - Setup constraints
extension SingUpVC {
    func addSubviews() {
        view.addSubview(headerTitle)
        
        let emailSV = UIStackView(arrangedSubviews: [emailLabel, emailTF], axis: .vertical, spacing: 10, alignment: .fill)
        let passwordSV = UIStackView(arrangedSubviews: [passwordLabel, passwordTF], axis: .vertical, spacing: 10, alignment: .fill)
        let confirmedPasswordSV = UIStackView(arrangedSubviews: [confirmedPasswordLabel, confirmedPasswordTF], axis: .vertical, spacing: 10, alignment: .fill)
        let loginButton = UIButton(title: "Login", titleColor: .systemPink, backgroundColor: .colorLight, isShadow: false)
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
 
        typealias UIViewControllerType = SingUpVC
        
        func makeUIViewController(context: Self.Context) -> Self.UIViewControllerType {
            return SingUpVC()
        }

        func updateUIViewController(_ uiViewController: SingUpVC, context: UIViewControllerRepresentableContext<SingUpVCPreview.ContainerView>) {}
    }
}
