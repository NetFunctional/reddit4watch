//
//  SettingsTableViewController.swift
//  Reddit4Watch
//
//  Created by Gregory Hogue on 2015-03-06.
//  Copyright (c) 2015 NetFunctional. All rights reserved.
//

import Foundation
import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBAction func doneButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func thumbnailSwitchChanged(sender: UISwitch) {
        
    }
    
    @IBAction func nsfwSwitchChanged(sender: UISwitch) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
