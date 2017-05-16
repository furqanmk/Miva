//
//  Miva.swift
//  Miva
//
//  Created by Furqan on 16/05/2017.
//  Copyright © 2017 Mind Valley. All rights reserved.
//

import Foundation
import Miva

class Post {
    
    class User {
        var id: String!
        var username: String!
        var name: String!
        var profileImageUrl: String!
        
        init(json: [String: AnyObject]) {
            self.id = json["id"] as! String
            self.username = json["username"] as! String
            self.name = json["name"] as! String
            
            var urls = json["profile_image"] as! [String: AnyObject]
            self.profileImageUrl = urls["small"] as! String
        }
    }
    
    var id: String!
    var created: Date!
    var color: UIColor!
    var likes: Int!
    var likedByUser: Bool!
    var user: User!
    var imageUrl: String!
    
    init(json: [String: AnyObject]) {
        self.id = json["id"] as! String
        self.created = Date.pinterestDate(string: json["created_at"] as! String)
        self.color = UIColor.fromHex(string: json["color"] as! String)
        self.likes = json["likes"] as! Int
        self.likedByUser = json["liked_by_user"] as! Bool
        self.user = User(json: json["user"] as! [String: AnyObject])
        
        var urls = json["urls"] as! [String: AnyObject]
        self.imageUrl = urls["regular"] as! String
    }
    
}


