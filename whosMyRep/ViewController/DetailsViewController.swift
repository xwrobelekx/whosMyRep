//
//  DetailsViewController.swift
//  whosMyRep
//
//  Created by Kamil Wrobel on 9/3/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var repInfo: Representative? {
        didSet{
            print("is it on main tread: \(Thread.isMainThread)")
            updateLabels()
        }
    }
    
    @IBOutlet weak var nameLabel      : UILabel!
    @IBOutlet weak var partyLabel     : UILabel!
    @IBOutlet weak var stateLabel     : UILabel!
    @IBOutlet weak var districtLabel  : UILabel!
    @IBOutlet weak var addressLabel   : UILabel!
    @IBOutlet weak var telepgoneLabel : UILabel!
    @IBOutlet weak var websiteLabel   : UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func updateLabels() {
        guard let rep = repInfo else {return}
        
        DispatchQueue.main.async {
            self.nameLabel.text      = rep.name
            self.partyLabel.text     = rep.party
            self.stateLabel.text     = rep.state
            self.districtLabel.text  = rep.district
            self.addressLabel.text   = rep.office
            self.telepgoneLabel.text = rep.phone
            self.websiteLabel.text   = rep.link
        }
    }
}
