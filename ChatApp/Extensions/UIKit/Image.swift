//
//  Image.swift
//  ChatApp
//
//  Created by Сергей Иванов on 05.02.2021.
//

import UIKit

extension UIImage {
    var scaledToSafeUploadSize: UIImage? {
        let maxImageSideLength: CGFloat = 480
        
        let largerSide: CGFloat = max(size.width, size.height)
        let rationScale: CGFloat = largerSide > maxImageSideLength ? largerSide / maxImageSideLength : 1
        let newimageSize = CGSize(width: size.width / rationScale, height: size.height / rationScale)
        
        return image(scaledTo: newimageSize)
    }
    
    func image(scaledTo size: CGSize) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        draw(in: CGRect(origin: .zero, size: size))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
