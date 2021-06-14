//
//  VoteAnswerObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 16.05.2021.
//

import Foundation

struct VoteAnswerObject: Codable {
    
    public var id: Int
    
    public var question: VoteQuestionObject
    
    public var person: PersonMinObject
    
}
