//
//  FeedViewController.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 15.04.2021.
//

import UIKit
import MaterialComponents

class FeedViewController: UITableViewController, MDCAppBarNavigationControllerDelegate {
    
    private let loadingBar = LoadingBar()
    public var appBarController: MDCAppBarNavigationController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appBarController.delegate = self
        tableView.separatorInset = .zero
        
        loadingBar.add(to: view, style: .large, color: .gray, offset: viewOffset)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ClientData.posts.onUpdate = {
            self.loadingBar.remove()
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ClientData.posts.onUpdate = nil
    }
    
    // MARK: AppBarNavigationController

    func appBarNavigationController(_ navigationController: MDCAppBarNavigationController, willAdd appBarViewController: MDCAppBarViewController, asChildOf viewController: UIViewController) {
        appBarViewController.headerView.backgroundColor = .accentColor
        appBarViewController.navigationBar.inkColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        appBarViewController.navigationBar.tintColor = .white
        appBarViewController.navigationBar.titleTextColor = .white
    }
    
    // MARK: Table view data source
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClientData.posts.data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedPostCell", for: indexPath) as! FeedPostCell
        let post = ClientData.posts.data[indexPath.row]
        
        if post.type == "app" {
            cell.iconImage.image = UIImage(named: "Icon_AppUpdate")
            cell.iconImage.tintColor = .redDarken2
        } else if post.type == "attention" {
            cell.iconImage.image = UIImage(named: "Icon_Attention")
            cell.iconImage.tintColor = .redDarken2
        } else if post.type == "document" {
            cell.iconImage.image = UIImage(named: "Icon_Document")
            cell.iconImage.tintColor = .purpleDarken2
        } else if post.type == "faq" {
            cell.iconImage.image = UIImage(named: "Icon_Faq")
            cell.iconImage.tintColor = .yellowAccent3
        } else if post.type == "holiday" {
            cell.iconImage.image = UIImage(named: "Icon_Holiday")
            cell.iconImage.tintColor = .orangeDarken2
        } else if post.type == "instruction" {
            cell.iconImage.image = UIImage(named: "Icon_Instruction")
            cell.iconImage.tintColor = .blueDarken2
        } else if post.type == "person" {
            cell.iconImage.image = UIImage(named: "Icon_Person")
            cell.iconImage.tintColor = .greenDarken2
        } else {
            cell.iconImage.image = UIImage(named: "Icon_News")
            cell.iconImage.tintColor = .orangeDarken2
        }
        
        cell.titleLabel.text = post.title
        cell.dateLabel.text = DateHelper.format(timestamp: post.createdAt)
        cell.bodyLabel.text = post.body
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
