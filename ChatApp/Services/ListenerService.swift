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
}
