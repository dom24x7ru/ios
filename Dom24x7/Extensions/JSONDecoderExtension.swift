//
//  JSONDecoderExtension.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 11.04.2021.
//

import Foundation

extension JSONDecoder {
    
    public static func decode<T>(_ type: T.Type, from anyObject: AnyObject?) -> T where T : Decodable {
        return try! JSONDecoder().decode(type, from: JSONSerialization.data(withJSONObject: anyObject ?? []))
    }
    
    public static func decode<T>(_ type: T.Type, from string: String) -> T where T: Decodable {
        return try! JSONDecoder().decode(type, from: string.data(using: .utf8)!)
    }
    
}
