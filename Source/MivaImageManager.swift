//
//  MivaImageManager.swift
//  Miva
//
//  Created by Furqan on 14/05/2017.
//  Copyright © 2017 Mind Valley. All rights reserved.
//

import Foundation

public class MivaImageManager {
    
    /// Shared manager used for image downloading.
    public static var shared: MivaManager<UIImage> {
        guard let s = _singleton else {
            _singleton = MivaManager<UIImage>()
            return _singleton!
        }
        return s
    }
    static private var _singleton: MivaManager<UIImage>?
    
}
