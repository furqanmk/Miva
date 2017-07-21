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
