//
//  ProfileVC.swift
//  ChatApp
//
//  Created by Сергей Иванов on 23.01.2021.
//

import UIKit

class ProfileVC: UIViewController {
    var groupButtonView: UIStackView!
    let headerTitle = UILabel(text: "Set up profile")
    let imagePicker = ImagePickerComponent()
    let nameLabel = UILabel(text: "Full name")
    let aboutLabel = UILabel(text: "About me")
    let sexLabel = UILabel(text: "Sex")
    let nameTF = TFWithBottemBorderLine(placeholder: "Name")
    let aboutTF = TFWithBottemBorderLine(placeholder: "About me")
    let goButton = UIButton(title: "Go to chats!", titleColor: UIColor.white, backgroundColor: .colorDark, isShadow: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
}

// MARK: - Setup constraints
extension ProfileVC {
    func addSubviews() {
        view.addSubview(headerTitle)
        view.addSubview(imagePicker)
        
        let emailSV = UIStackView(arrangedSubviews: [nameLabel, nameTF], axis: .vertical, spacing: 10, alignment: .fill)
        let passwordSV = UIStackView(arrangedSubviews: [aboutLabel, aboutTF], axis: .vertical, spacing: 10, alignment: .fill)
        let sexSV = UIStackView(arrangedSubviews: [sexLabel, UISegmentedControl(first: "Male", second: "Female")], axis: .vertical, spacing: 10, alignment: .fill)
        
        groupButtonView = UIStackView(arrangedSubviews: [emailSV, passwordSV, sexSV, goButton], axis: .vertical, spacing: 40, alignment: .fill)
        view.addSubview(groupButtonView)
    }
    
    func setupConstraints() {
        goButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            headerTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        imagePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagePicker.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 30),
            imagePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        groupButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupButtonView.topAnchor.constraint(equalTo: imagePicker.bottomAnchor, constant: 30),
            groupButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            groupButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}


import SwiftUI
struct ProfileVCPreview: PreviewProvider{
   
    static var previews: some View{
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
 
        typealias UIViewControllerType = ProfileVC
        
        func makeUIViewController(context: Self.Context) -> Self.UIViewControllerType {
            return ProfileVC()
        }

        func updateUIViewController(_ uiViewController: ProfileVC, context: UIViewControllerRepresentableContext<ProfileVCPreview.ContainerView>) {}
    }
}
