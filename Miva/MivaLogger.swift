//
//  MivaLogger.swift
//  Miva
//
//  Created by Furqan on 14/05/2017.
//  Copyright © 2017 Mind Valley. All rights reserved.
//

import Foundation

public struct MivaLogger {
    
    fileprivate static let Tag = "[MIVA]"
    
    fileprivate enum Level : String {
        case Debug = "[DEBUG]"
        case Error = "[ERROR]"
    }
    
    fileprivate static func log(_ level: Level, _ message: @autoclosure () -> String, _ error: MivaError? = nil) {
        if let error = error {
            print("\(Tag)\(level.rawValue) \(message()) with error \(error)")
        } else {
            print("\(Tag)\(level.rawValue) \(message())")
        }
    }
    
    static func debug(message: @autoclosure () -> String, error: MivaError? = nil) {
        #if DEBUG
            log(.Debug, message, error)
        #endif
    }
    
    static func error(message: @autoclosure () -> String, error: MivaError? = nil) {
        log(.Error, message, error)
    }
    
}

