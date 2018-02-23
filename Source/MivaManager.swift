//
//  Downloader.swift
//  Miva
//
//  Created by Furqan on 14/05/2017.
//  Copyright © 2017 Mind Valley. All rights reserved.
//

import Foundation

public class MivaManager<T: DataConvertible> {
    
    init() {
        cache = MivaCache()
        requests = [:]
    }
    
    /// Create a new manager
    static func new<T: DataConvertible>(caller: T.Type) -> MivaManager<T> {
        return MivaManager<T>()
    }
    
    /// Cache used by this manager
    public var cache: MivaCache<T>
    
    /// Download requests in progress
    public var requests: [String: MivaRequest<T>]
    
    /// Downloads the asset from network
    @discardableResult public func fetch(url: String, progress: ((Double) -> Void)?, success: @escaping (T) -> Void, failure: @escaping (MivaError) -> Void) -> MivaRequest<T>? {
        
        if let cachedObject = cache.retrieve(url) {
            success(cachedObject)
            return nil
        }
        
        // Checks if there is any pending download for the same URL. If yes, simply appends the handlers. Otherwise creates a new task
        if let pending = requests[url] {
            pending.appendHandlers(progress: progress, success: success, failure: failure)
            return pending
        } else {
            return MivaRequest(path: url, progress: progress, success: { [weak self] (result) in
                self?.cache.save(result, forUrl: url)
                success(result)
            }, failure: failure)
        }
    }
}
