//
//  ProfileVC.swift
//  ChatApp
//
//  Created by Сергей Иванов on 23.01.2021.
//

import UIKit
import FirebaseAuth

class ProfileVC: UIViewController{
    var groupButtonView: UIStackView!
    let headerTitle = UILabel(text: "Set up profile")
    let imagePicker = ImagePickerComponent()
    let nameLabel = UILabel(text: "Full name")
    let aboutLabel = UILabel(text: "About me")
    let sexLabel = UILabel(text: "Sex")
    let nameTF = TFWithBottemBorderLine(placeholder: "Name")
    let aboutTF = TFWithBottemBorderLine(placeholder: "About me")
    let goButton = UIButton(title: "Go to chats!", titleColor: UIColor.white, backgroundColor: .colorDark, isShadow: false)
    let sexSegmentedControl = UISegmentedControl(first: "Male", second: "Female")
    var currentUser: User
    
    init(user: User) {
        self.currentUser = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        
        imagePicker.target = self
        
        goButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        imagePicker.button.addTarget(self, action: #selector(add), for: .touchUpInside)
    }
    
    @objc func add() {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func submit() {
        let fullname = nameTF.text
        let about = aboutTF.text
        let sex = sexSegmentedControl.titleForSegment(at: sexSegmentedControl.selectedSegmentIndex)
        let image = imagePicker.imageView.image
    
        FirestoreService.shared.saveProfile(target: self, uid: currentUser.uid, email: currentUser.email!, fullname: fullname, avatarImage: image!, sex: sex, about: about) {
            user in
            let tabVC = TabVC(user: user)
            tabVC.modalPresentationStyle = .fullScreen
            self.present(tabVC, animated: true, completion: nil)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension ProfileVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        imagePicker.imageView.image = image
    }
}

// MARK: - Setup constraints

extension ProfileVC {
    func addSubviews() {
        view.addSubview(headerTitle)
        view.addSubview(imagePicker)
        
        let emailSV = UIStackView(arrangedSubviews: [nameLabel, nameTF], axis: .vertical, spacing: 10, alignment: .fill)
        let passwordSV = UIStackView(arrangedSubviews: [aboutLabel, aboutTF], axis: .vertical, spacing: 10, alignment: .fill)
        let sexSV = UIStackView(arrangedSubviews: [sexLabel, sexSegmentedControl], axis: .vertical, spacing: 10, alignment: .fill)
        
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


