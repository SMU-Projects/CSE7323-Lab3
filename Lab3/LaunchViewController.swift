//
//  LaunchViewController.swift
//  Lab3
//
//  Created by Will Lacey on 10/20/19.
//  Copyright © 2019 Will Lacey. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var moduleBButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(StepModel.getLives() == 0)
        {
            self.moduleBButton.isEnabled = false
        }
        else
        {
            self.moduleBButton.isEnabled = true
        }
    }
}
