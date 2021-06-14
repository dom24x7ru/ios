//
//  IMMessageBodyObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 16.05.2021.
//

import Foundation

struct IMMessageBodyObject: Codable {
    
    public var text: String
    
    public var history: [IMHistoryItemObject]?
    
    public var aMessage: IMAnswerMessageObject?
    
}
