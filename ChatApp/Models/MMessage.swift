//
//  MMessage.swift
//  ChatApp
//
//  Created by Сергей Иванов on 07.02.2021.
//

import Foundation
import FirebaseFirestore
import MessageKit


struct MMessage: Hashable, MessageType {
    var sender: SenderType
    let content: String
    let sentDate: Date
    let avatarImageStringURL: String
    let id: String?
    
    var messageId: String {
        return id ?? UUID().uuidString
    }
    var kind: MessageKind {
        return .text(content)
    }
    
    init(content: String, chatId: String, username: String, avatarImageStringURL: String) {
        self.content = content
        self.sentDate = Date()
        self.avatarImageStringURL = avatarImageStringURL
        self.id = nil
        self.sender = Sender(senderId: chatId, displayName: username)
    }
      
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let content = data["content"] as? String,
              let date = data["date"] as? Timestamp,
              let chatId = data["chatId"] as? String,
              let username = data["username"] as? String,
              let avatarImageStringURL = data["avatarImageStringURL"] as? String
           
        else { return nil }
        
        self.content = content
        self.sentDate = date.dateValue()
        self.sender = Sender(senderId: chatId, displayName: username)
        self.avatarImageStringURL = avatarImageStringURL
        self.id = document.documentID
    }
    
    var representaion: [String: Any] {
        var rep: [String: Any] = ["content": content]
        rep["date"] = sentDate
        rep["chatId"] = sender.senderId
        rep["username"] = sender.displayName
        rep["avatarImageStringURL"] = avatarImageStringURL
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    
    static func == (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.messageId == lhs.messageId
    }
}
