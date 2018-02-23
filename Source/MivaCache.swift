//
//  Cache.swift
//  Miva
//
//  Created by Furqan on 14/05/2017.
//  Copyright © 2017 Mind Valley. All rights reserved.
//

import Foundation

public class MivaCache<T: DataConvertible> {
    // Memory Cache
    private let cache = NSCache<NSString, AnyObject>()

    // Allows periodic clearing of expired cache
    private var lastAccesses: [String: Date] = [:]
    private var expiryCheckTimer: Timer = Timer()
    
    /// The largest cache cost of memory cache. The total cost is pixel count of
    /// all cached images in memory.
    /// Cache will be purged automatically when a
    /// memory warning notification is received.
    public var maximumSize: UInt = 0 {
        didSet {
            self.cache.totalCostLimit = Int(maximumSize)
        }
    }
    
    /// The amount of time an image can stay in cache
    public var life: TimeInterval = 60 * 15

    init() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(clearCache), name: .UIApplicationDidReceiveMemoryWarning, object: nil)
        expiryCheckTimer = Timer.init(timeInterval: 30, target: self, selector: #selector(clearExpiredCache), userInfo: nil, repeats: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        expiryCheckTimer.invalidate()
    }
    
    /// Save new object to the cache
    public func save(_ object: T, forUrl url: String) {
        cache.setObject(object as AnyObject, forKey: url as NSString)
        lastAccesses[url] = Date()
    }
    
    /// Retrieve image corresponding the URL
    public func retrieve(_ url: String) -> T? {
        lastAccesses[url] = Date()
        return cache.object(forKey: url as NSString) as? T
    }
    
    /// Delete items that were last accessed more than the life of cache
    @objc public func clearExpiredCache() {
        for (url, access) in lastAccesses {
            if Date().timeIntervalSince(access) > life {
                remove(url)
            }
        }
    }
    
    /// Remove item for the corresponding the URL
    public func remove(_ url: String) {
        cache.removeObject(forKey: url as NSString)
    }
    
    /// Clear all objects from the cache
    @objc public func clearCache() {
        cache.removeAllObjects()
    }
}
