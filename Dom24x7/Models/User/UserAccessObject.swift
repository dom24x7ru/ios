//
//  UserAccessObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 05.05.2021.
//

import Foundation
import HandyJSON

class UserAccessObject: HandyJSON, Codable {
    
    public var name: AccessObject!
    
    public var mobile: AccessObject!
    
    public var telegram: AccessObject!
    
    required init() { }
    
}
