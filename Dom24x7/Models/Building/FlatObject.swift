//
//  FlatObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 27.04.2021.
//

import Foundation

struct FlatObject: Codable {
    
    public var id: Int
    
    public var number: Int
    
    public var floor: Int
    
    public var section: Int
    
    public var rooms: Int
    
    public var square: Float
    
    public var residents: [ResidentOwnerObject]?
    
}
