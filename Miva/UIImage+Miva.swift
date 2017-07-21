//
//  UIImage+Miva.swift
//  Miva
//
//  Created by Furqan on 14/05/2017.
//  Copyright © 2017 Mind Valley. All rights reserved.
//

import Foundation

public extension UIImage {
    func data(compressionQuality: Float = 1.0) -> Data! {
        let hasAlpha = self.hasAlpha()
        let data = hasAlpha ? UIImagePNGRepresentation(self) : UIImageJPEGRepresentation(self, CGFloat(compressionQuality))
        return data
    }
    
    func hasAlpha() -> Bool {
        guard let alphaInfo = self.cgImage?.alphaInfo else { return false }
        switch alphaInfo {
        case .first, .last, .premultipliedFirst, .premultipliedLast, .alphaOnly:
            return true
        case .none, .noneSkipFirst, .noneSkipLast:
            return false
        }
    }
}

extension UIImage : DataConvertible, DataRepresentable {
    
    public typealias Result = UIImage
    
    private static var imageSync = NSLock()
    
    static func safeImageWithData(_ data: Data) -> Result? {
        imageSync.lock()
        let image = UIImage(data: data)
        imageSync.unlock()
        return image
    }
    
    public class func convertFromData(_ data: Data) -> Result? {
        let image = UIImage.safeImageWithData(data)
        return image
    }
    
    public func asData() -> Data! {
        return self.data() as Data!
    }
    
}
