//
//  MivaCollectionViewController.swift
//  Miva
//
//  Created by Furqan on 16/05/2017.
//  Copyright © 2017 Mind Valley. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MivaCollectionViewController: UICollectionViewController {
    
    // let inspirations = Inspiration.allInspirations()
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let patternImage = UIImage(named: "Pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        collectionView!.backgroundColor = UIColor.clear
        collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
        
        PostCollection.shared.getPosts()
        PostCollection.shared.delegate = self
    }
    
}

extension MivaCollectionViewController: PostCollectionDelegate {
    func didLoad() {
        collectionView?.reloadData()
    }
}

extension MivaCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PostCollection.shared.list.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InspirationCell", for: indexPath) as! MivaCollectionViewCell
        cell.post = PostCollection.shared.list[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = collectionViewLayout as! MivaLayout
        let offset = layout.dragOffset * CGFloat(indexPath.item)
        if collectionView.contentOffset.y != offset {
            collectionView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        }
    }
    
    
}
