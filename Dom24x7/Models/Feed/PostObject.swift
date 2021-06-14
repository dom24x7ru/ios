//
//  PostObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 27.04.2021.
//

import Foundation

struct PostObject: Codable {
    
    public var id: Int
    
    public var createdAt: Int
    
    public var type: String
    
    public var title: String
    
    public var body: String
    
    public var url: String?
    
}
