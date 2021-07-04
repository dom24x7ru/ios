//
//  UIViewControllerExtension.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 04.07.2021.
//

import UIKit

extension UIViewController {
        
    public var viewOffset: CGFloat {
        return UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height ?? 0)
    }
    
}
