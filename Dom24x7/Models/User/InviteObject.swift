//
//  InviteObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 27.04.2021.
//

import Foundation

struct InviteObject: Codable {
    
    public var id: Int
    
    public var createdAt: Int
    
    public var code: String
    
    public var used: Bool
    
    public var person: InvitePersonObject?
    
    public var flat: FlatMinObject?
    
}
