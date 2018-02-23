//
//  MivaSettings.swift
//  Miva
//
//  Created by Furqan on 15/05/2017.
//  Copyright © 2017 Mind Valley. All rights reserved.
//

import Foundation

class MivaSettings {
    public static var requestTimeoutSeconds = 60.0
    public static var maximumSimultaneousDownloads = 50
    public static var requestCachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy
}
