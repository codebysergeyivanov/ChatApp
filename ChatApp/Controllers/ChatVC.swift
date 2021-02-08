//
//  ChatVC.swift
//  ChatApp
//
//  Created by Сергей Иванов on 08.02.2021.
//

import UIKit
import SDWebImage
import MessageKit
import InputBarAccessoryView
import FirebaseFirestore

class ChatVC: MessagesViewController {
    private var messages = [MMessage]()
    private let user: MUser
    private let chat: MChat
    var messageObserver: ListenerRegistration?
    
    init(user: MUser, chat: MChat) {
        self.user = user
        self.chat = chat
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        messageObserver?.remove()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.backgroundColor = #colorLiteral(red: 0.9136453271, green: 0.9137768149, blue: 0.9136165977, alpha: 1)
        messageInputBar.delegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        title = chat.fullname
        
        messageObserver = ListenerService.shared.observeMessagesObject(chat: chat) {
            result in
            switch result {
            case .success(let message):
                self.insertNewMessage(message: message)
            case .failure(let e):
                print(e.localizedDescription)
            }
        }
    }
    
    private func insertNewMessage(message: MMessage) {
        messages.append(message)
        messages.sort()
        messagesCollectionView.reloadData()
    }
}

extension ChatVC: MessagesLayoutDelegate {
    
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

extension ChatVC: MessagesDisplayDelegate {
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    }
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .black : .white
    }
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        return isFromCurrentSender(message: message) ? avatarView.sd_setImage(with: URL(string: user.avatarImageStringURL), completed: nil) : avatarView.sd_setImage(with: URL(string: chat.avatarImageStringURL), completed: nil)
    }
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        return .bubble
    }
}

extension ChatVC: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let message = MMessage(content: text, chatId: user.uid, username: user.fullname, avatarImageStringURL: user.avatarImageStringURL)
        FirestoreService.shared.sendMessage(chat: chat, message: message) {
            result in
            switch result {
            case .success():
                self.messagesCollectionView.scrollToLastItem()
            case .failure(let e):
                print(e.localizedDescription)
            }
        }
        inputBar.inputTextView.text = ""
    }
}
