//
//  MChat.swift
//  ChatApp
//
//  Created by Сергей Иванов on 07.02.2021.
//

import Foundation
import FirebaseFirestore


struct MChat: Hashable, Decodable {
    let fullname: String
    let about: String
    let lastMessage: String
    let avatarImageStringURL: String
    let chatId: String
    
    init(fullname: String, about: String, lastMessage: String, avatarImageStringURL: String, chatId: String) {
        self.fullname = fullname
        self.about = about
        self.lastMessage = lastMessage
        self.avatarImageStringURL = avatarImageStringURL
        self.chatId = chatId
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil }
        guard let fullname = data["fullname"] as? String,
              let about = data["about"] as? String,
              let lastMessage = data["lastMessage"] as? String,
              let avatarImageStringURL = data["avatarImageStringURL"] as? String,
              let chatId = data["chatId"] as? String
        else { return nil }
        
        self.fullname = fullname
        self.about = about
        self.lastMessage = lastMessage
        self.avatarImageStringURL = avatarImageStringURL
        self.chatId = chatId
    }
    
    var representaion: [String: Any] {
        var rep = ["fullname": fullname]
        rep["about"] = about
        rep["lastMessage"] = lastMessage
        rep["avatarImageStringURL"] = avatarImageStringURL
        rep["chatId"] = chatId
        return rep
    }
}
