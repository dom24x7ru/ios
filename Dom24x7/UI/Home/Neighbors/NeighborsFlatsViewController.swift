//
//  NeighborsFlatsViewController.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 09.07.2021.
//

import UIKit

class NeighborsFlatsViewController: UITableViewController {
    
    public var flats: [FlatObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! NeighborsPersonsViewController
        let selectedCell = sender as! NeighborsFlatCell
        let flat = flats[selectedCell.index]
        
        destination.title = title! + ", " + Localization.flat + " №" + String(flat.number)
        
        destination.loadResidents(in: flat.number)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NeighborsFlatCell", for: indexPath) as! NeighborsFlatCell
        let flat = flats[indexPath.row]
        let personsCount = flat.residents!.count

        cell.index = indexPath.row
        cell.flatLabel.text = Localization.flat + " №" + String(flat.number)
        cell.personsLabel.text = Localization.persons + ": " + String(personsCount)
        cell.roomsLabel.text = Localization.rooms + ": " + String(flat.rooms)
        cell.sizeLabel.text = Localization.size + ": " + String(flat.square) + " " + Localization.squareMeter
        cell.accessoryType = personsCount == 0 ? .none : .disclosureIndicator
        cell.isUserInteractionEnabled = personsCount > 0
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
