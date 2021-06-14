//
//  IMAnswerMessageObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 16.05.2021.
//

import Foundation

struct IMAnswerMessageObject: Codable {
    
    public var id: Int
    
    public var createdAt: Int
    
    public var text: String?
    
}
