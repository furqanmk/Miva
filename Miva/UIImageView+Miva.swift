//
//  UIImageView+Miva.swift
//  Miva
//
//  Created by Furqan on 14/05/2017.
//  Copyright © 2017 Mind Valley. All rights reserved.
//

import UIKit

public extension UIImageView {
    public func setImage(url: String) {
        MivaImageManager.shared.fetch(url: url, progress: nil, success: { (image) in
            self.image = image
        }) { (error) in
            print(error)
        }
    }
}
