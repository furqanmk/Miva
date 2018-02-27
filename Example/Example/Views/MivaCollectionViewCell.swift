//
//  MivaCollectionViewCell.swift
//  Miva
//
//  Created by Furqan on 16/05/2017.
//  Copyright © 2017 Mind Valley. All rights reserved.
//

import UIKit

class MivaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var imageCoverView: UIView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var heartImageView: UIImageView!
    
    
    var post: Post? {
        didSet{
            if let post = post {
                imageView.setImage(url: post.imageUrl)
                profileImageView.setImage(url: post.user.profileImageUrl)
                usernameLabel.text = post.user.username
                timeLabel.text = post.created.pinterestStyle()
                likesLabel.text = "\(post.likes ?? 0)"
                if post.likedByUser {
                    heartImageView.image = UIImage(named: "heart_filled")
                }
            }
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let standardHeight = MivaLayoutConstants.Cell.standardHeight
        let featuredHeight = MivaLayoutConstants.Cell.featuredHeight
        
        let delta = 1 - ((featuredHeight - frame.height) / (featuredHeight - standardHeight))
        
        let minAlpha: CGFloat = 0.1
        let maxAlpha: CGFloat = 0.75
        let gamma = maxAlpha - (delta * (maxAlpha - minAlpha))
        imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        timeLabel.alpha = gamma
        usernameLabel.alpha = gamma
        likesLabel.alpha = gamma
        heartImageView.alpha = gamma
        profileImageView.alpha = gamma * 2
    }

}
