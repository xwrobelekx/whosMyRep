//
//  StateListTableViewController.swift
//  whosMyRep
//
//  Created by Kamil Wrobel on 9/3/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class StateListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }

 

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stateList.dataAcces.statesList.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        let state = stateList.dataAcces.statesList[indexPath.row]
        cell.textLabel?.text = state
        return cell
    }
 

  
  
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRepTVC" {
            let destinationVC = segue.destination as? RepresentativeListTableViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let statePressed = stateList.dataAcces.statesList[indexPath.row]
            //this return state code which i can pass in to the URL function
            guard let stateCode = getStateCode(state: statePressed) else {return}
            destinationVC?.curentState = stateCode
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
   
    
    
    
    //MARK: - Helper Methods
    
    
    // Helper method to get the state code
    
    func getStateCode(state: String) -> String? {
        guard let stateCode = stateList.dataAcces.statesListDictionary[state] else {
            print("Unable to pull state code form dictionary of states.")
            //FIXME: keep an eye on this empty string
            return ""
        }
        
        return stateCode
    }
}
