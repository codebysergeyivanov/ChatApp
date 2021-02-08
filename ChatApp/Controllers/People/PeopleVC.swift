//
//  ProfileVC.swift
//  ChatApp
//
//  Created by Сергей Иванов on 27.01.2021.
//

import UIKit
import SDWebImage

class PeopleVC: UIViewController {
    let fullnameUserLabel = UILabel(text: "Full Name")
    let aboutLabel = UILabel(text: "Text about a person")
    let imageView = UIImageView()
    var bottomArea = UIView()
    var userInfoSV: UIStackView!
    let input = Input()
    var delegate: NavigationPeopleDelegate? = nil
    var user: MUser!
    
    init(user: MUser) {
        self.user = user
        fullnameUserLabel.text = user.fullname
        aboutLabel.text = user.about
        imageView.sd_setImage(with: URL(string: user.avatarImageStringURL), completed: nil)
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
        
        input.button.addTarget(self, action: #selector(send), for: .touchUpInside)
    }
    
    @objc func send() {
        guard let message = input.text, message != "" else { return }
        dismiss(animated: true) {
            self.delegate?.startChat(message: message, receivedId: self.user.uid )
        }
    }
    
    override func viewDidLayoutSubviews() {
        bottomArea.clipsToBounds = true
        let path = UIBezierPath(roundedRect: bottomArea.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 15, height: 15))
                let mask = CAShapeLayer()
                mask.path = path.cgPath
        bottomArea.layer.mask = mask
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension PeopleVC {
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

extension PeopleVC {
    func addSubviews() {
        view.addSubview(imageView)
        userInfoSV = UIStackView(arrangedSubviews: [fullnameUserLabel, aboutLabel], axis: .vertical, spacing: 5, alignment: .fill)
        bottomArea.addSubview(userInfoSV)
        view.addSubview(bottomArea)
        view.addSubview(input)
    }
    func configureConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        bottomArea.translatesAutoresizingMaskIntoConstraints = false
        userInfoSV.translatesAutoresizingMaskIntoConstraints = false
        input.translatesAutoresizingMaskIntoConstraints = false
        
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
            input.heightAnchor.constraint(equalToConstant: 50),
            input.topAnchor.constraint(equalTo: userInfoSV.bottomAnchor, constant: 25),
            input.leadingAnchor.constraint(equalTo: bottomArea.leadingAnchor, constant: 20),
            input.trailingAnchor.constraint(equalTo: bottomArea.trailingAnchor, constant: -20)
        ])
        
        
    }
}
