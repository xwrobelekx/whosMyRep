//
//  RepresentativeListTableViewController.swift
//  whosMyRep
//
//  Created by Kamil Wrobel on 9/3/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class RepresentativeListTableViewController: UITableViewController {
    
    var curentState : String?{
        didSet{
            guard let curentStateCode = curentState else {
                print("there is no state code in the RepresentativeTVC")
                return
                
            }
            RepModelController.shared.fetchRepresentatives(stateCode: curentStateCode) { (result) in
                guard let results = result else {return}
                DispatchQueue.main.async {
                    self.arrayOfReps = results
                    print(self.arrayOfReps)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var arrayOfReps: [Representative] = []
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayOfReps.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell             = tableView.dequeueReusableCell(withIdentifier: "RepCell", for: indexPath)
        let rep              = arrayOfReps[indexPath.row]
        cell.textLabel?.text = rep.name
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier        == "toDetailView" {
            let destinationVC      = segue.destination as? DetailsViewController
            guard let indexPath    = tableView.indexPathForSelectedRow else {return}
            let repInfo            = arrayOfReps[indexPath.row]
            destinationVC?.repInfo = repInfo
            
        }
    }
}
