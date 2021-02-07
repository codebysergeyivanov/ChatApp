//
//  ConfirmUserVC.swift
//  ChatApp
//
//  Created by Сергей Иванов on 27.01.2021.
//

import UIKit


class ConfirmPeopleVC: UIViewController {
    let fullnameUserLabel = UILabel(text: "Full Name")
    let aboutLabel = UILabel(text: "Text about a person")
    let imageView = UIImageView()
    var bottomArea = UIView()
    var userInfoSV: UIStackView!
    var buttonsSV: UIStackView!
    let acceptButton = UIButton(title: "Accept", titleColor: UIColor.white, backgroundColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), isShadow: false)
    let denyButton: UIButton = {
        let button = UIButton(title: "Deny", titleColor: UIColor.systemPink, backgroundColor: .white, isShadow: false)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemPink.cgColor
        return button
    }()
    var chat: MChat!
    var delegate: NavigationConfirmPeopleDelegate?
    
    init(chat: MChat) {
        self.chat = chat
        fullnameUserLabel.text = chat.fullname
        aboutLabel.text = chat.about
        imageView.sd_setImage(with: URL(string: chat.avatarImageStringURL), completed: nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageView()
        configureBottomArea()
        addSubviews()
        configureConstraints()
        acceptButton.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
        denyButton.addTarget(self, action: #selector(denyButtonTapped), for: .touchUpInside)
    }
    
    @objc func acceptButtonTapped() {
        dismiss(animated: true, completion: {
            self.delegate?.accept(chat: self.chat)
        })
    }
    
    @objc func denyButtonTapped() {
        dismiss(animated: true, completion: {
            self.delegate?.deny(chat: self.chat)
        })
    }
    
    override func viewDidLayoutSubviews() {
        bottomArea.clipsToBounds = true
        let path = UIBezierPath(roundedRect: bottomArea.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 15, height: 15))
                let mask = CAShapeLayer()
                mask.path = path.cgPath
        bottomArea.layer.mask = mask
    }
}

extension ConfirmPeopleVC {
    func configureImageView() {
        imageView.contentMode = .scaleAspectFill
    }
    func configureBottomArea() {
        let path = UIBezierPath(roundedRect: bottomArea.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 15, height: 15))
                let mask = CAShapeLayer()
                mask.path = path.cgPath
        bottomArea.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        bottomArea.layer.mask = mask
    }
}

extension ConfirmPeopleVC {
    func addSubviews() {
        view.addSubview(imageView)
        userInfoSV = UIStackView(arrangedSubviews: [fullnameUserLabel, aboutLabel], axis: .vertical, spacing: 10, alignment: .fill)
        buttonsSV = UIStackView(arrangedSubviews: [acceptButton, denyButton], axis: .horizontal, spacing: 10, alignment: .fill)
        buttonsSV.distribution = .fillEqually
        bottomArea.addSubview(userInfoSV)
        bottomArea.addSubview(buttonsSV)
        view.addSubview(bottomArea)
    }
    func configureConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        bottomArea.translatesAutoresizingMaskIntoConstraints = false
        userInfoSV.translatesAutoresizingMaskIntoConstraints = false
        buttonsSV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomArea.topAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            bottomArea.heightAnchor.constraint(equalToConstant: 200),
            bottomArea.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomArea.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomArea.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userInfoSV.topAnchor.constraint(equalTo: bottomArea.topAnchor, constant: 30),
            userInfoSV.leadingAnchor.constraint(equalTo: bottomArea.leadingAnchor, constant: 20),
            userInfoSV.trailingAnchor.constraint(equalTo: bottomArea.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            buttonsSV.heightAnchor.constraint(equalToConstant: 50),
            buttonsSV.topAnchor.constraint(equalTo: userInfoSV.bottomAnchor, constant: 20),
            buttonsSV.leadingAnchor.constraint(equalTo: bottomArea.leadingAnchor, constant: 20),
            buttonsSV.trailingAnchor.constraint(equalTo: bottomArea.trailingAnchor, constant: -20)
        ])
    }
}


