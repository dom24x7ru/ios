//
//  TabBarController.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 12.04.2021.
//

import UIKit
import MaterialComponents

class TabBarController: UIViewController {
    
    public let bottomNavBarController = MDCBottomNavigationBarController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Thread.runOnBackgroundThread {
            SocketHandler.subscribeToAll()
        }
        initializeComponents()
        setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Custom functions
    
    private func initializeComponents() {
        let feedViewController = UIStoryboard.getViewController("FeedViewController", in: "Home") as! FeedViewController
        feedViewController.appBarController = MDCAppBarNavigationController()
        feedViewController.title = Localization.feed
        feedViewController.tabBarItem = UITabBarItem(title: feedViewController.title, image: UIImage(named: "TabBar_Feed"), tag: 0)
        
        let neighborsViewController = UIStoryboard.getViewController("NeighborsViewController", in: "Home") as! NeighborsViewController
        neighborsViewController.appBarController = MDCAppBarNavigationController()
        neighborsViewController.title = Localization.neighbors
        neighborsViewController.tabBarItem = UITabBarItem(title: neighborsViewController.title, image: UIImage(named: "TabBar_Neighbors"), tag: 1)
        
        let chatsViewController = UIStoryboard.getViewController("ChatsViewController", in: "Home") as! ChatsViewController
        chatsViewController.appBarController = MDCAppBarNavigationController()
        chatsViewController.title = Localization.chats
        chatsViewController.tabBarItem = UITabBarItem(title: chatsViewController.title, image: UIImage(named: "TabBar_Chats"), tag: 2)

        let otherViewController = UIStoryboard.getViewController("OtherViewController", in: "Home") as! OtherViewController
        otherViewController.appBarController = MDCAppBarNavigationController()
        otherViewController.title = Localization.other
        otherViewController.tabBarItem = UITabBarItem(title: otherViewController.title, image: UIImage(named: "TabBar_Other"), tag: 3)
        
        feedViewController.appBarController.pushViewController(feedViewController, animated: false)
        neighborsViewController.appBarController.pushViewController(neighborsViewController, animated: false)
        chatsViewController.appBarController.pushViewController(chatsViewController, animated: false)
        otherViewController.appBarController.pushViewController(otherViewController, animated: false)
        
        bottomNavBarController.navigationBar.barTintColor = .accentColor
        bottomNavBarController.navigationBar.selectedItemTintColor = .white
        bottomNavBarController.navigationBar.selectedItemTitleColor = .white
        bottomNavBarController.navigationBar.unselectedItemTintColor = .white
        bottomNavBarController.viewControllers = [feedViewController.appBarController, neighborsViewController.appBarController, chatsViewController.appBarController, otherViewController.appBarController]
        
        addChild(bottomNavBarController)
        view.addSubview(bottomNavBarController.view)
    }
    
}
