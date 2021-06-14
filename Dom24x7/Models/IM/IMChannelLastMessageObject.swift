//
//  IMChannelLastMessageObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 16.05.2021.
//

import Foundation

struct IMChannelLastMessageObject: Codable {
    
    public var createdAt: Int
    
    public var person: PersonMinObject?
    
    public var body: IMMessageBodyObject
    
}
