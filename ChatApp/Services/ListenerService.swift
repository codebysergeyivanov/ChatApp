//
//  ListenerService.swift
//  ChatApp
//
//  Created by Сергей Иванов on 06.02.2021.
//

import Firebase
import FirebaseFirestore
import FirebaseAuth

class ListenerService {
    static let shared = ListenerService()
    private init() {}
    
    let db = Firestore.firestore()
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    private var currentUserId: String  {
        return Auth.auth().currentUser!.uid
    }
    private var waitingChatsRef: CollectionReference {
        return db.collection(["users", currentUserId, "waitingChats"].joined(separator: "/"))
    }
    
    private var activeChatsRef: CollectionReference {
        return db.collection(["users", currentUserId, "activeChats"].joined(separator: "/"))
    }
    
    
    func observeObject(_ obj: [MUser], complition: @escaping (Result<[MUser], Error>) -> Void) -> ListenerRegistration {
        var obj = obj
        let listener = usersRef.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                complition(.failure(error!))
                return
            }
            snapshot.documentChanges.forEach { diff in
                guard let muser = MUser(document: diff.document) else { return }
                if (diff.type == .added) {
                    guard !obj.contains(muser) else { return }
                    guard muser.uid != self.currentUserId else { return }
                    obj.append(muser)
                }
                if (diff.type == .modified) {
                    guard let index = obj.firstIndex(of: muser) else { return}
                    obj[index] = muser
                }
                if (diff.type == .removed) {
                    guard let index = obj.firstIndex(of: muser) else { return}
                    obj.remove(at: index)
                }
            }
            complition(.success(obj))
        }
        return listener
    }
    
    func observeWaitingChatsObject(_ obj: [MChat], complition: @escaping (Result<[MChat], Error>) -> Void) -> ListenerRegistration {
        var obj = obj
        let listener = waitingChatsRef.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                complition(.failure(error!))
                return
            }
            snapshot.documentChanges.forEach { diff in
                guard let mchat = MChat(document: diff.document) else { return }
                if (diff.type == .added) {
                    guard !obj.contains(mchat) else { return }
                    obj.append(mchat)
                }
                if (diff.type == .modified) {
                    guard let index = obj.firstIndex(of: mchat) else { return}
                    obj[index] = mchat
                }
                if (diff.type == .removed) {
                    guard let index = obj.firstIndex(of: mchat) else { return}
                    obj.remove(at: index)
                }
            }
            complition(.success(obj))
        }
        return listener
    }
    
    func observeActiveChatsObject(_ obj: [MChat], complition: @escaping (Result<[MChat], Error>) -> Void) -> ListenerRegistration {
        var obj = obj
        let listener = activeChatsRef.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                complition(.failure(error!))
                return
            }
            snapshot.documentChanges.forEach { diff in
                guard let mchat = MChat(document: diff.document) else { return }
                if (diff.type == .added) {
                    guard !obj.contains(mchat) else { return }
                    obj.append(mchat)
                }
                if (diff.type == .modified) {
                    guard let index = obj.firstIndex(of: mchat) else { return}
                    obj[index] = mchat
                }
                if (diff.type == .removed) {
                    guard let index = obj.firstIndex(of: mchat) else { return}
                    obj.remove(at: index)
                }
            }
            complition(.success(obj))
        }
        return listener
    }
    
    func observeMessagesObject(chat: MChat, complition: @escaping (Result<MMessage, Error>) -> Void) -> ListenerRegistration {
        let userMessagesRef = usersRef.document(currentUserId).collection("activeChats").document(chat.chatId).collection("messages")
        let listener = userMessagesRef.addSnapshotListener { querySnapshot, e in
            guard let snapshot = querySnapshot else {
                complition(.failure(e!))
                return
            }
            snapshot.documentChanges.forEach { diff in
                guard let message = MMessage(document: diff.document) else { return }
                if (diff.type == .added) {
                    complition(.success(message))
                }
            }
        }
        return listener
    }
}
