//
//  FeedViewController.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 15.04.2021.
//

import UIKit
import MaterialComponents

class FeedViewController: UITableViewController, MDCAppBarNavigationControllerDelegate {
    
    public var appBarController: MDCAppBarNavigationController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appBarController.delegate = self
        tableView.separatorInset = .zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ClientData.posts.onUpdate = {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ClientData.posts.onUpdate = nil
    }
    
    // MARK: AppBarNavigationController

    func appBarNavigationController(_ navigationController: MDCAppBarNavigationController, willAdd appBarViewController: MDCAppBarViewController, asChildOf viewController: UIViewController) {
        appBarViewController.headerView.backgroundColor = Colors.accentColor
        appBarViewController.navigationBar.inkColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        appBarViewController.navigationBar.tintColor = .white
        appBarViewController.navigationBar.titleTextColor = .white
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClientData.posts.data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedPersonCell", for: indexPath) as! FeedPersonCell
        let post = ClientData.posts.data[indexPath.row]
        
        cell.titleLabel.text = post.title
        cell.dateLabel.text = DateHelper.format(timestamp: post.createdAt)
        cell.bodyLabel.text = post.body
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
