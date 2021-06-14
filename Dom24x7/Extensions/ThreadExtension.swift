//
//  ThreadExtension.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 20.04.2021.
//

import Foundation

extension Thread {
    
    public static func runOnBackgroundThread(_ method: (() -> Void)!) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            method?()
        }
    }
    
    public static func runOnUiThread(_ method: (() -> Void)!) {
        DispatchQueue.main.async {
            method?()
        }
    }
    
}
