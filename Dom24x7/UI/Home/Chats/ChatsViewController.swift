//
//  ChatsViewController.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 15.04.2021.
//

import UIKit
import MaterialComponents

class ChatsViewController: UITableViewController, MDCAppBarNavigationControllerDelegate {
    
    private let loadingBar = LoadingBar()
    public var appBarController: MDCAppBarNavigationController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appBarController.delegate = self
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
        
        loadingBar.add(to: view, style: .large, color: .gray, offset: viewOffset)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ClientData.imChannels.onUpdate = {
            self.loadingBar.remove()
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ClientData.imChannels.onUpdate = nil
    }
    
    // MARK: AppBarNavigationController

    func appBarNavigationController(_ navigationController: MDCAppBarNavigationController, willAdd appBarViewController: MDCAppBarViewController, asChildOf viewController: UIViewController) {
        appBarViewController.headerView.backgroundColor = .accentColor
        appBarViewController.navigationBar.inkColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        appBarViewController.navigationBar.tintColor = .white
        appBarViewController.navigationBar.titleTextColor = .white
    }
    
    // MARK: Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClientData.imChannels.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatsConversationCell", for: indexPath) as! ChatsConversationCell
        let chat = ClientData.imChannels.data[indexPath.row]
        
        cell.titleLabel.text = chat.title ?? Localization.noTitle
        cell.bodyLabel.text = chat.lastMessage?.body.text ?? Localization.noMessagesHereYet
        cell.dateLabel.text = DateHelper.formatForIM(timestamp: chat.lastMessage?.createdAt ?? 0)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
