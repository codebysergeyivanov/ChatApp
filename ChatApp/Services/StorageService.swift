//
//  StorageServices.swift
//  ChatApp
//
//  Created by Сергей Иванов on 05.02.2021.
//

import Foundation
import FirebaseStorage
import FirebaseAuth

class StorageService {
    static let shared = StorageService()
    private init() {}
    
    private let storageRef = Storage.storage().reference()
    private var avatarsRef: StorageReference {
        return storageRef.child("avatars")
    }
    private var currentUserId: String  {
        return Auth.auth().currentUser!.uid
    }
    
    func upload(target: UIViewController, image: UIImage, complition: @escaping (_ url: URL?) -> Void) {
        guard let scaledImage = image.scaledToSafeUploadSize, let imageData = scaledImage.jpegData(compressionQuality: 0.4) else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        self.avatarsRef.child(currentUserId).putData(imageData, metadata: metadata) { metadata, e in
            guard let _ = metadata else {
                Messages.show(target: target, title: "Ошибка", message: "Uh-oh, an error occurred!", handler: nil)
                print("@upload Error: Uh-oh, an error occurred!")
                return
            }
            
            self.avatarsRef.child(self.currentUserId).downloadURL { (url, error) in
                guard let downloadURL = url else {
                    Messages.show(target: target, title: "Ошибка", message: "Uh-oh, an error occurred!", handler: nil)
                    print("@downloadURL Error: Uh-oh, an error occurred!")
                    return
                }
                complition(downloadURL)
            }
        }
    }
}
