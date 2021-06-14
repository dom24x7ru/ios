//
//  SignInWithInviteObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 10.04.2021.
//

import Foundation
import HandyJSON

class SignInWithInviteObject: HandyJSON {
    
    public var mobile: String!
    
    public var invite: String?
    
    required init() { }
    
    init(mobile: String, invite: String?) {
        self.mobile = mobile
        self.invite = invite
    }
    
}
