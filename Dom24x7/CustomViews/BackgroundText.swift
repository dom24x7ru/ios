//
//  BackgroundText.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 10.07.2021.
//

import UIKit

class BackgroundText {
    
    private var isAdded = false
    private var label = UILabel()
    
    
    public func add(to view: UIView, text: String, size: CGFloat, color: UIColor, offset: CGFloat) {
        if (isAdded) && (label.text != nil) && (label.text != text) {
            label.text = text
        }
        
        if isAdded {
            return
        }
        
        isAdded = true
        label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        label.text = text
        label.textAlignment = .center
        label.font = .systemFont(ofSize: size)
        label.textColor = color
        label.alpha = 0.8
        label.center = view.center
        label.center.y = view.center.y - offset
        label.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        
        view.addSubview(label)
    }
    
    public func remove() {
        if !isAdded {
            return
        }
        
        isAdded = false
        
        if Thread.isMainThread {
            clearSuperview()
        } else {
            DispatchQueue.main.async {
                self.clearSuperview()
            }
        }
    }
    
    private func clearSuperview() {
        label.removeFromSuperview()
    }
    
}
