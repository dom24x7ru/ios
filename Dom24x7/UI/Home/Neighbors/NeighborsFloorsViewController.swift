//
//  NeighborsFloorsViewController.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 08.07.2021.
//

import UIKit

class NeighborsFloorsViewController: UITableViewController {
    
    private var isInitial: Bool = true
    public var floors: [Int: FloorObject] = [:]
    public var indexes: [Int] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isInitial {
            isInitial = false
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! NeighborsFlatsViewController
        let selectedCell = sender as! NeighborsFloorCell
        let flats = floors[selectedCell.index]!.flats
        
        destination.title = title! + ", " + Localization.floor + " " + String(selectedCell.index)
        destination.flats = flats
    }
    
    // MARK: Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indexes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NeighborsFloorCell", for: indexPath) as! NeighborsFloorCell
        let floorNumber = indexes[indexPath.row]
        let floor = floors[floorNumber]!
        
        cell.index = floorNumber
        cell.floorLabel.text = Localization.floor + " " + String(floorNumber)
        cell.flatsLabel.text = Localization.flats + ": " + String(floor.flatMin) + " - " + String(floor.flatMax)
        cell.populatedLabel.text = Localization.populated + ": " + String(floor.populated) + " " + Localization.of + " " + String(floor.flatsCount)
        cell.personsLabel.text = Localization.persons + ": " + String(floor.persons)
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
