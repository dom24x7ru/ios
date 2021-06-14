//
//  VoteObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 16.05.2021.
//

import Foundation

struct VoteObject: Codable {
    
    public var id: Int
    
    public var title: String
    
    public var createdAt: Int
    
    public var multi: Bool
    
    public var anonymous: Bool
    
    public var closed: Bool
    
    public var house: Bool
    
    public var section: Int?
    
    public var floor: Int?
    
    public var questions: [VoteQuestionObject]
    
    public var answers: [VoteAnswerObject]
    
    public var persons: Int
    
}
