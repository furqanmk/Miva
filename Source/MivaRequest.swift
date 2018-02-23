//
//  MivaDownloadRequest.swift
//  Miva
//
//  Created by Furqan on 14/05/2017.
//  Copyright © 2017 Mind Valley. All rights reserved.
//

import Foundation

/// This stores the blocks that come from the fetch method.
/// This is used to ensure only one request goes out for multiple of the same url.
fileprivate class HandlerContainer<T> {
    var progress:((Double) -> Void)?
    var success:((T) -> Void)?
    var failure:((MivaError) -> Void)?
    init(progress: ((Double) -> Void)?, success: ((T) -> Void)?, failure: ((MivaError) -> Void)?) {
        self.progress = progress
        self.success = success
        self.failure = failure
    }
}

public class MivaRequest<T: DataConvertible>: NSObject, URLSessionDataDelegate {
    fileprivate var url: URL
    fileprivate var handlerContainers: [HandlerContainer<T>] = [ ]
    private var requestCount: Int
    private var expectedSize: Int
    private var buffer: Data
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = MivaSettings.requestTimeoutSeconds
        configuration.timeoutIntervalForResource = MivaSettings.requestTimeoutSeconds
        configuration.httpMaximumConnectionsPerHost = MivaSettings.maximumSimultaneousDownloads
        configuration.requestCachePolicy = MivaSettings.requestCachePolicy
        
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        return session
    }()
    
    @discardableResult public init?(path: String, progress: ((Double) -> Void)?, success: @escaping (T) -> Void, failure: @escaping (MivaError) -> Void) {
        
        guard let url = URL(string: path) else {
            failure(.invalidUrl)
            return nil
        }
        
        self.url = url
        self.requestCount = 1
        self.expectedSize = 0
        self.buffer = Data()
        super.init()
 
        // Executes the download task
        let request = URLRequest(url: url)
        session.dataTask(with: request).resume()
        
        // Appends all the call-backs as a single object in the handlerContainers array to be called in a loop
        let container = HandlerContainer(progress: progress, success: success, failure: failure)
        handlerContainers.append(container)
        
    }
    
    /// Cancels the download if all the requesting callers call this function
    public func cancel() {
        requestCount -= 1
        if requestCount == 0 {
            session.invalidateAndCancel()
            handlerContainers.removeAll()
        }
    }
    
    /// Appends a new call-back container
    public func appendHandlers(progress: ((Double) -> Void)?, success: @escaping (T) -> Void, failure: @escaping (MivaError) -> Void) {
        let container = HandlerContainer(progress: progress, success: success, failure: failure)
        handlerContainers.append(container)
        requestCount += 1
    }

    
    /// MARK : URLSessionDataDelegate
    
    /// Used to get the total size of the downloading file in order to calculate progress
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        self.expectedSize = Int(response.expectedContentLength)
        print(expectedSize)
        completionHandler(URLSession.ResponseDisposition.allow)
    }
    
    /// Used to calculate the progress
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.buffer.append(data)
        let progress = Double(buffer.count) / Double(expectedSize)
        signalProgress(part: progress)
    }
    
    /// Download is complete
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        signalProgress(part: 1.0)
        if let error = error {
            signalFailure(error: .other(error: error))
            return
        }
        if let result = T.convertFromData(buffer) as? T {
            signalSuccess(result: result)
        }
    }
}

/// Extension contains functions that call 'progress', 'success' and 'failure' call-backs provided by the calling object(s)
extension MivaRequest {
    
    /// Calls 'progress' call-backs on all calling objects
    func signalProgress(part: Double) {
        for container in handlerContainers {
            DispatchQueue.main.async {
                container.progress?(part)
            }
        }
    }
    
    /// Calls 'success' call-backs on all calling objects
    func signalSuccess(result: T) {
        for container in handlerContainers {
            DispatchQueue.main.async() {
                container.success?(result)
            }
        }
    }
    
    /// Calls 'failure' call-backs on all calling objects
    func signalFailure(error: MivaError) {
        for container in handlerContainers {
            DispatchQueue.main.async {
                container.failure?(error)
            }
        }
    }
}

/// Extension allows requests to be compared on the basis of its URL
extension MivaRequest {
    static func ==(a: MivaRequest, b: MivaRequest) -> Bool {
        return a.url == b.url
    }
}
