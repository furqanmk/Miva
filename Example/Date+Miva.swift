//
//  Date+Miva.swift
//  Miva
//
//  Created by Furqan on 16/05/2017.
//  Copyright © 2017 Mind Valley. All rights reserved.
//

import Foundation

extension Date {
    static func pinterestDate(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: string)!
    }
    
    func pinterestStyle() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
