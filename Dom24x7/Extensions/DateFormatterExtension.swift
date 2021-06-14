//
//  DateFormatterExtension.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 29.04.2021.
//

import Foundation

extension DateFormatter {
    
    convenience init(dateFormat: String) {
        self.init()
        
        self.dateFormat = dateFormat
    }
    
}
