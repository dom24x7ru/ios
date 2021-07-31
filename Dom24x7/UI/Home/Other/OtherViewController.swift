//
//  OtherViewController.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 15.04.2021.
//

import UIKit
import MaterialComponents

class OtherViewController: UITableViewController, MDCAppBarNavigationControllerDelegate {

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
        ClientData.user.onUpdate = {
            Preferences.saveUserData(ClientData.user.data)
            self.loadingBar.remove()
            self.tableView.reloadData()
        }
        ClientData.instructions.onUpdate = {
            self.tableView.reloadData()
        }
        ClientData.documents.onUpdate = {
            self.tableView.reloadData()
        }
        ClientData.votes.onUpdate = {
            self.tableView.reloadData()
        }
        ClientData.faq.onUpdate = {
            self.tableView.reloadData()
        }
        ClientData.recommendations.onUpdate = {
            self.tableView.reloadData()
        }
        ClientData.invites.onUpdate = {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ClientData.user.onUpdate = nil
    }
    
    // MARK: AppBarNavigationController

    func appBarNavigationController(_ navigationController: MDCAppBarNavigationController, willAdd appBarViewController: MDCAppBarViewController, asChildOf viewController: UIViewController) {
        appBarViewController.headerView.backgroundColor = .accentColor
        appBarViewController.navigationBar.inkColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        appBarViewController.navigationBar.tintColor = .white
        appBarViewController.navigationBar.titleTextColor = .white
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClientData.user.data == nil ? 0 : 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return getProfileCell(at: indexPath)
        case 1:
            return getInstructionsCell(at: indexPath)
        case 2:
            return getDocumentsCell(at: indexPath)
        case 3:
            return getVotingCell(at: indexPath)
        case 4:
            return getFAQCell(at: indexPath)
        case 5:
            return getRecommendationsCell(at: indexPath)
        case 6:
            return getInvitationsCell(at: indexPath)
        default:
            return getLogoutCell(at: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)!.reuseIdentifier == "OtherLogoutCell" {
            Preferences.clearAll()
            
            UIApplication.shared.keyWindow!.rootViewController = UIStoryboard(name: "SignIn", bundle: nil).instantiateInitialViewController()
        }
    }
    
    // MARK: - Custom cells
    
    private func getProfileCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherProfileCell", for: indexPath) as! OtherProfileCell
        let userData = Preferences.getUserData()
        
        if userData.person!.name == nil {
            cell.nameLabel.text = Localization.notSpecified
        } else if userData.person!.surname == nil {
            cell.nameLabel.text = userData.person!.name
        } else {
            cell.nameLabel.text = userData.person!.surname! + " " + userData.person!.name! + " " + userData.person!.midname!
        }
        
        cell.locationLabel.text = Localization.section + " " + String(userData.resident!.flat.section) + ", " + Localization.floor + " " + String(userData.resident!.flat.floor) + ", " + Localization.flatShort + " " + String(userData.resident!.flat.number)
        cell.phoneNumberLabel.text = userData.mobile
        cell.telegramLabel.text = userData.person!.telegram ?? Localization.notSpecified
        
        return cell
    }
    
    private func getInstructionsCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherInstructionsCell", for: indexPath) as! OtherDetailCell

        cell.isUserInteractionEnabled = ClientData.instructions.data.count > 0
        cell.titleLabel.text = Localization.instructions
        cell.detailLabel.text = Localization.available + ": \(ClientData.instructions.data.count)"
        
        return cell
    }
    
    private func getDocumentsCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherDocumentsCell", for: indexPath) as! OtherDetailCell

        cell.isUserInteractionEnabled = ClientData.documents.data.count > 0
        cell.titleLabel.text = Localization.documents
        cell.detailLabel.text = Localization.available + ": \(ClientData.documents.data.count)"
        
        return cell
    }
    
    private func getVotingCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherVotingCell", for: indexPath) as! OtherDetailCell

        cell.isUserInteractionEnabled = ClientData.votes.data.count > 0
        cell.titleLabel.text = Localization.voting
        cell.detailLabel.text = Localization.available + ": \(ClientData.votes.data.count)"
        
        return cell
    }
    
    private func getFAQCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherFAQCell", for: indexPath) as! OtherDetailCell

        cell.isUserInteractionEnabled = ClientData.faq.data.count > 0
        cell.titleLabel.text = Localization.faq
        cell.detailLabel.text = Localization.available + ": \(ClientData.faq.data.count)"
        
        return cell
    }
    
    private func getRecommendationsCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherRecommendationsCell", for: indexPath) as! OtherDetailCell

        cell.isUserInteractionEnabled = ClientData.recommendations.data.count > 0
        cell.titleLabel.text = Localization.recommendations
        cell.detailLabel.text = Localization.available + ": \(ClientData.recommendations.data.count)"
        
        return cell
    }
    
    private func getInvitationsCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherInvitationsCell", for: indexPath) as! OtherCell

        cell.titleLabel.text = Localization.invitations
        
        return cell
    }
    
    private func getLogoutCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherLogoutCell", for: indexPath) as! OtherCell
        
        cell.titleLabel.text = Localization.logout
        
        return cell
    }
    
}
