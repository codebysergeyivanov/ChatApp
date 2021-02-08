//
//  ChatVC.swift
//  ChatApp
//
//  Created by Сергей Иванов on 08.02.2021.
//

import UIKit
import MessageKit

class ChatVC: MessagesViewController {
    private var messages = [MMessage]()
    private let user: MUser
    private let chat: MChat
    
    init(user: MUser, chat: MChat) {
        self.user = user
        self.chat = chat
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = chat.fullname
    }
}

extension ChatVC: MessagesDataSource {
    func currentSender() -> SenderType {
        return Sender(senderId: user.uid, displayName: user.fullname)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.item]
    }
    
    func numberOfItems(inSection section: Int, in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return 1
    }
    
    
}
