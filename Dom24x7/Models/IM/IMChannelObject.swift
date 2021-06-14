//
//  IMChannelObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 16.05.2021.
//

import Foundation

struct IMChannelObject: Codable {
    
    public var id: Int
    
    public var title: String?
    
    public var `private`: Bool
    
    public var lastMessage: IMChannelLastMessageObject?
    
    public var count: Int
    
    public var persons: [PersonMinObject]?
    
}
