//
//  ResidentObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 05.05.2021.
//

import Foundation

struct ResidentObject: Codable {
    
    public var id: Int
    
    public var createdAt: String
    
    public var updatedAt: String
    
    public var personId: Int
    
    public var flatId: Int
    
    public var flat: FlatObject
    
    public var isOwner: Bool
    
}
