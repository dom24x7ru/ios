//
//  NeighborsPersonsViewController.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 10.07.2021.
//

import UIKit

class NeighborsPersonsViewController: UITableViewController {
    
    private let backgroundText = BackgroundText()
    private let loadingBar = LoadingBar()
    private var residents: [ResidentOwnerObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
        
        loadingBar.add(to: view, style: .large, color: .gray, offset: viewOffset)
    }
    
    public func loadResidents(in flatNumber: Int) {
        SocketHandler.flatInfo(flatNumber: flatNumber) { result in
            switch result {
            case .failure(let error):
                self.handleFailure(message: (error as! ErrorObject).message)
            case .success(let response):
                self.handleSuccess(response as! [ResidentOwnerObject])
            }
        }
    }
    
    private func handleFailure(message: String) {
        loadingBar.remove()
        backgroundText.add(to: view, text: message, size: 20, color: .systemGray, offset: viewOffset)
    }
    
    private func handleSuccess(_ data: [ResidentOwnerObject]) {
        residents = data
        
        loadingBar.remove()
        tableView.reloadData()
    }
    
    // MARK: Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NeighborsPersonCell", for: indexPath) as! NeighborsPersonCell
        let resident = residents[indexPath.row]

        cell.setName(resident.name, surname: resident.surname, midname: resident.midname)
        cell.setMobile(resident.mobile)
        cell.setTelegram(resident.telegram)
        
        return cell
    }
    
}
