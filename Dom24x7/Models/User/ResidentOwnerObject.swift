//
//  ResidentOwnerObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 27.04.2021.
//

import Foundation

struct ResidentOwnerObject: Codable {
    
    public var personId: Int
    
    public var surname: String?
    
    public var name: String?
    
    public var midname: String?
    
    public var deleted: Bool
    
}
