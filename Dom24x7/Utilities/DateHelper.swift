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
        
        return dateFormatter.string(from: date)
    }
    
    public static func formatForIM(timestamp: Int) -> String {
        let dayMs = 86400000
        let weekMs = 604800000
        let timePassed = Date().currentTimestamp() - timestamp
        let date = Date(timestamp: timestamp)
        let dateFormatter = DateFormatter(dateFormat: timePassed < dayMs ? "hh:mm" : timePassed < weekMs ? "EEEE" : "dd.MM.yyyy")
        
        dateFormatter.weekdaySymbols = Localization.weekdaySymbols
        
        return dateFormatter.string(from: date)
    }
    
}
