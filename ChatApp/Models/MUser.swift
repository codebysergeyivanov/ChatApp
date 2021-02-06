//
//  MUser.swift
//  ChatApp
//
//  Created by Сергей Иванов on 04.02.2021.
//

import Foundation
import FirebaseFirestore


struct MUser: Hashable, Decodable {
    let fullname: String
    let about: String
    let email: String
    let sex: String
    let avatarImageURL: String
    let uid: String
    
    init(fullname: String, about: String, email: String, sex: String, avatarString: String, uid: String) {
        self.fullname = fullname
        self.about = about
        self.email = email
        self.sex = sex
        self.avatarImageURL = avatarString
        self.uid = uid
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil }
        guard let fullname = data["fullname"] as? String,
              let email = data["email"] as? String,
              //let avatarString = data["avatarStirng"] as? String,
              let about = data["about"] as? String,
              let sex = data["sex"] as? String,
              let uid = data["uid"] as? String
        else { return nil }
        
        self.fullname = fullname
        self.about = about
        self.email = email
        self.sex = sex
        self.avatarImageURL = "nil"
        self.uid = uid
    }
    
    var representaion: [String: Any] {
        var rep = ["fullname": fullname]
        rep["about"] = about
        rep["email"] = email
        rep["sex"] = sex
        rep["avatarString"] = avatarImageURL
        rep["uid"] = uid
        return rep
    }
}
