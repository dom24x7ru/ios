//
//  DateExtension.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 29.04.2021.
//

import Foundation

extension Date {
    
    public init(timestamp: Int) {
        self.init(timeIntervalSince1970: Double(timestamp / 1000))
    }
    
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
}
