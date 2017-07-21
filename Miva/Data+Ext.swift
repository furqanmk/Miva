//
//  Data+Ext.swift
//  Miva
//
//  Created by Maroof Khan on 21/07/2017.
//  Copyright © 2017 Mind Valley. All rights reserved.
//

extension Data : DataConvertible, DataRepresentable {
    
    public typealias Result = Data
    
    public static func convertFromData(_ data: Data) -> Result? {
        return data
    }
    
    public func asData() -> Data! {
        return self
    }
}
