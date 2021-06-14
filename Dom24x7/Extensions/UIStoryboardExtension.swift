//
//  UIStoryboardExtension.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 10.04.2021.
//

import UIKit

extension UIStoryboard {
    
    public static func getViewController(_ viewControllerName: String, in storyboardName: String) -> UIViewController {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: viewControllerName)
    }
    
}
