//
//  PersonMinObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 13.05.2021.
//

import Foundation

struct PersonMinObject: Codable {
    
    public var id: Int
    
    public var surname: String?
    
    public var name: String?
    
    public var midname: String?
    
    public var deleted: Bool?
    
    public var flat: FlatMinObject?
    
}
