//
//  NeighborsViewController.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 15.04.2021.
//

import UIKit
import MaterialComponents

class NeighborsViewController: UIViewController, MDCAppBarNavigationControllerDelegate {
    
    public var appBarController: MDCAppBarNavigationController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appBarController.delegate = self
    }
    
    // MARK: AppBarNavigationController

    func appBarNavigationController(_ navigationController: MDCAppBarNavigationController, willAdd appBarViewController: MDCAppBarViewController, asChildOf viewController: UIViewController) {
        appBarViewController.headerView.backgroundColor = .accentColor
        appBarViewController.navigationBar.inkColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        appBarViewController.navigationBar.tintColor = .white
        appBarViewController.navigationBar.titleTextColor = .white
    }
    
}
