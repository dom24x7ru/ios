//
//  IMMessage.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 16.05.2021.
//

import Foundation

struct IMMessage: Codable {
    
    public var id: Int
    
    public var createdAt: Int
    
    public var updatedAt: Int
    
    public var person: PersonMinObject
    
    public var channel: IMMessageChannelObject
    
    public var body: IMMessageBodyObject
    
}
