//
//  MMessage.swift
//  ChatApp
//
//  Created by Сергей Иванов on 07.02.2021.
//

import Foundation
import FirebaseFirestore


struct MMessage: Hashable, Decodable {
    let content: String
    let date: Date
    let chatId: String
    let username: String
    let avatarImageStringURL: String
    
    init(content: String, chatId: String, username: String, avatarImageStringURL: String) {
        self.content = content
        self.date = Date()
        self.chatId = chatId
        self.username = username
        self.avatarImageStringURL = avatarImageStringURL
    }
      
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil }
        guard let content = data["content"] as? String,
              let date = data["date"] as? Date,
              let chatId = data["chatId"] as? String,
              let username = data["username"] as? String,
              let avatarImageStringURL = data["avatarImageStringURL"] as? String
           
        else { return nil }
        
        self.content = content
        self.date = date
        self.chatId = chatId
        self.username = username
        self.avatarImageStringURL = avatarImageStringURL
    }
    
    var representaion: [String: Any] {
        var rep: [String: Any] = ["content": content]
        rep["date"] = date
        rep["chatId"] = chatId
        rep["username"] = username
        rep["avatarImageStringURL"] = avatarImageStringURL
        return rep
    }
}
