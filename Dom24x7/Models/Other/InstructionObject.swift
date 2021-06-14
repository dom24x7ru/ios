//
//  InstructionObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 13.05.2021.
//

import Foundation

struct InstructionObject: Codable {
    
    public var id: Int
    
    public var title: String
    
    public var subtitle: String?
    
    public var body: [InstructionStepObject]
    
}
