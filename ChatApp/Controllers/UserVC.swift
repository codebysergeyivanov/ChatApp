//
//  ProfileVC.swift
//  ChatApp
//
//  Created by Сергей Иванов on 27.01.2021.
//

import UIKit


class UserVC: UIViewController {
    let fullnameUserLabel = UILabel(text: "Full Name")
    let aboutLabel = UILabel(text: "Text about a person")
    let imageView = UIImageView()
    var bottomArea = UIView()
    var userInfoSV: UIStackView!
    let input = Input()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageView()
        configureBottomArea()
        addSubviews()
        configureConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        bottomArea.clipsToBounds = true
        let path = UIBezierPath(roundedRect: bottomArea.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 15, height: 15))
                let mask = CAShapeLayer()
                mask.path = path.cgPath
        bottomArea.layer.mask = mask
    }
}

extension UserVC {
    func configureImageView() {
        imageView.image = UIImage(named: "human1")
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

extension UserVC {
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
