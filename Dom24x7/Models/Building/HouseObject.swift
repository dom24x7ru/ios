//
//  HouseObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 16.05.2021.
//

import Foundation

struct HouseObject: Codable {
    
    public var id: Int
    
    public var address: String
    
    // MARK:- TODO
    //public var dadata: [Any]
    
    public var coord: HouseCoordinatesObject
    
    public var extra: HouseExtraObject

}
