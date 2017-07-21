//
//  String+Ext.swift
//  Miva
//
//  Created by Maroof Khan on 21/07/2017.
//  Copyright © 2017 Mind Valley. All rights reserved.
//

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
