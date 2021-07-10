//
//  FlatInfoObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 10.07.2021.
//

import Foundation
import HandyJSON

class FlatInfoObject: HandyJSON {
    
    public var flatNumber: Int!
    
    required init() { }
    
    init(flatNumber: Int) {
        self.flatNumber = flatNumber
    }
    
}
