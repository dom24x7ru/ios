//
//  NeighborsViewController.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 15.04.2021.
//

import UIKit
import MaterialComponents

class NeighborsViewController: UITableViewController, MDCAppBarNavigationControllerDelegate {
    
    private let loadingBar = LoadingBar()
    private var indexes: [Int] = []
    public var appBarController: MDCAppBarNavigationController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appBarController.delegate = self
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
        
        loadingBar.add(to: view, style: .large, color: .gray, offset: viewOffset)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ClientData.sections.onUpdate = {
            self.indexes = ClientData.sections.data.keys.sorted()
            
            self.loadingBar.remove()
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ClientData.sections.onUpdate = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! NeighborsFloorsViewController
        let selectedCell = sender as! NeighborsSectionCell
        let floors = ClientData.sections.data[selectedCell.index]!.floors
        
        destination.title = Localization.section + " " + String(selectedCell.index)
        destination.floors = floors
        destination.indexes = floors.keys.sorted()
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
        return indexes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NeighborsSectionCell", for: indexPath) as! NeighborsSectionCell
        let sectionNumber = indexes[indexPath.row]
        let section = ClientData.sections.data[sectionNumber]!
        
        cell.index = sectionNumber
        cell.sectionLabel.text = Localization.section + " " + String(sectionNumber)
        cell.floorsLabel.text = Localization.floors + ": " + String(section.floorsCount)
        cell.flatsLabel.text = Localization.flats + ": " + String(section.flatMin) + " - " + String(section.flatMax)
        cell.populatedLabel.text = Localization.populated + ": " + String(section.populated) + " " + Localization.of + " " + String(section.flatsCount)
        cell.personsLabel.text = Localization.persons + ": " + String(section.persons)
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
