//
//  FaqObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 13.05.2021.
//

import Foundation

struct FaqObject: Codable {
    
    public var id: Int
    
    public var title: String
    
    public var body: String
    
    public var category: FaqCategoryObject
    
}
