//
//  JSONEncoderExtension.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 20.04.2021.
//

import Foundation

extension JSONEncoder {
    
    public static func encodeToString<T>(_ value: T) -> String where T : Encodable {
        return String(data: try! JSONEncoder().encode(value), encoding: .utf8)!
    }

}
