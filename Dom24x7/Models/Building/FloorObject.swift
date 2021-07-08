//
//  FloorObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 07.07.2021.
//

import Foundation

struct FloorObject: Codable {
    
    public var flats: [FlatObject]
    
    public var flatMin: Int
    
    public var flatMax: Int
    
    public var filled: Int
    
    public var persons: Int
    
}
