//
//  ScClientExtension.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 14.06.2021.
//

import ScClient

extension ScClient {
    
    public func waitTillConnect() {
        while !self.isConnected() {
            usleep(100 * 1000)
        }
    }
    
}
