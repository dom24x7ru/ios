//
//  PersonObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 05.05.2021.
//

import Foundation

struct PersonObject: Codable {
    
    public var id: Int
    
    public var createdAt: String
    
    public var updatedAt: String
    
    public var userId: Int
    
    public var surname: String?
    
    public var name: String?
    
    public var midname: String?
    
    public var birthday: String?
    
    public var sex: String
    
    public var biography: String?
    
    public var telegram: String?
    
    public var access: UserAccessObject
    
}
