//
//  SignInWithCodeObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 10.04.2021.
//

import Foundation
import HandyJSON

class SignInWithCodeObject: HandyJSON {
    
    public var mobile: String!
    
    public var code: String!
    
    required init() { }
    
    init(mobile: String, code: String?) {
        self.mobile = mobile
        self.code = code
    }
    
}
