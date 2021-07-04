//
//  LoadingBar.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 04.07.2021.
//

import UIKit

class LoadingBar {
    
    public enum Style {
        case large
        case small
    }
    
    private let activityView = UIView()
    private var activityIndicator: UIActivityIndicatorView!
    private var isAdded = false
    
    
    public func add(to view: UIView, style: Style, color: UIColor, offset: CGFloat) {
        if isAdded {
            if !activityIndicator.isAnimating {
                activityIndicator.startAnimating()
            }
            
            return
        }
        
        isAdded = true
        activityView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        activityView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        activityIndicator = UIActivityIndicatorView(style: style == Style.large ? .whiteLarge : .white)
        activityIndicator.center = activityView.center
        activityIndicator.center.y = activityView.center.y - offset
        activityIndicator.color = color
        activityIndicator.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        activityIndicator.startAnimating()
        
        activityView.addSubview(activityIndicator)
        view.addSubview(activityView)
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
        activityView.removeFromSuperview()
        
        for view in activityView.subviews {
            view.removeFromSuperview()
        }
    }
    
}
