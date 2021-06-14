//
//  DateHelper.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 29.04.2021.
//

import Foundation

class DateHelper {
    
    public static func format(timestamp: Int) -> String {
        let date = Date(timestamp: timestamp)
        let dateFormatter = DateFormatter(dateFormat: "d.MM.yyyy hh:mm")
        
        dateFormatter.monthSymbols = Localization.monthSymbols
        
        return dateFormatter.string(from: date)
    }
    
}
