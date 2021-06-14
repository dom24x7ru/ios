//
//  ErrorObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 11.04.2021.
//

import Foundation

struct ErrorObject: Codable, Error {
    
    public var code: String
    
    public var message: String
    
}
