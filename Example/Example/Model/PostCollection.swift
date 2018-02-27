//
//  PostCollection.swift
//  Miva
//
//  Created by Furqan on 16/05/2017.
//  Copyright © 2017 Mind Valley. All rights reserved.
//

import Foundation
import Miva

protocol PostCollectionDelegate {
    func didLoad()
}

class PostCollection {
    static var shared = PostCollection()
    private init() { }
    
    var delegate: PostCollectionDelegate?
    
    var list: [Post] = [ ] {
        didSet {
            delegate?.didLoad()
        }
    }
    
    func getPosts() {
        MivaRequest<JSON>(path: "https://pastebin.com/raw/wgkJgazE", progress: nil, success: { [weak self] (json) in
            for postJson in json.array {
                let post = Post(json: postJson as! [String: AnyObject])
                self?.list.append(post)
            }
        }) { (error) in
            print(error)
        }
    }
}
