//
//  UserObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 16.04.2021.
//

import Foundation

struct UserObject: Codable {
    
    public var id: Int
    
    public var mobile: String
    
    public var banned: Bool
    
    public var role: UserRoleObject
    
    public var person: PersonObject?
    
    public var resident: ResidentObject?
    
}
