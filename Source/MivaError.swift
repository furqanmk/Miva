//
//  MivaError.swift
//  Miva
//
//  Created by Furqan on 14/05/2017.
//  Copyright © 2017 Mind Valley. All rights reserved.
//

import Foundation

public enum MivaError {
    case invalidUrl
    case invalidResponse
    case not200
    case other(error: Error?)
}
