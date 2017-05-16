//
//  DataConvertible.swift
//  Miva
//
//  Created by Furqan on 14/05/2017.
//  Copyright © 2017 Mind Valley. All rights reserved.
//

import Foundation

public protocol DataConvertible {
    associatedtype Result
    
    static func convertFromData(_ data:Data) -> Result?
}

public protocol DataRepresentable {
    
    func asData() -> Data!
}

private let imageSync = NSLock()

extension UIImage : DataConvertible, DataRepresentable {
    
    public typealias Result = UIImage
    
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

extension String : DataConvertible, DataRepresentable {
    
    public typealias Result = String
    
    public static func convertFromData(_ data: Data) -> Result? {
        let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        return string as Result?
    }
    
    public func asData() -> Data! {
        return self.data(using: String.Encoding.utf8)
    }
    
}

extension Data : DataConvertible, DataRepresentable {
    
    public typealias Result = Data
    
    public static func convertFromData(_ data: Data) -> Result? {
        return data
    }
    
    public func asData() -> Data! {
        return self
    }
    
}

public enum JSON : DataConvertible, DataRepresentable {
    public typealias Result = JSON
    
    case Dictionary([String:AnyObject])
    case Array([AnyObject])
    
    public static func convertFromData(_ data: Data) -> Result? {
        do {
            let object : Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
            switch (object) {
            case let dictionary as [String:AnyObject]:
                return JSON.Dictionary(dictionary)
            case let array as [AnyObject]:
                return JSON.Array(array)
            default:
                return nil
            }
        } catch {
            MivaLogger.error(message: "Invalid JSON data", error: .invalidResponse)
            return nil
        }
    }
    
    public func asData() -> Data! {
        switch (self) {
        case .Dictionary(let dictionary):
            return try? JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions())
        case .Array(let array):
            return try? JSONSerialization.data(withJSONObject: array, options: JSONSerialization.WritingOptions())
        }
    }
    
    public var array : [AnyObject]! {
        switch (self) {
        case .Dictionary(_):
            return nil
        case .Array(let array):
            return array
        }
    }
    
    public var dictionary : [String:AnyObject]! {
        switch (self) {
        case .Dictionary(let dictionary):
            return dictionary
        case .Array(_):
            return nil
        }
    }
    
}
