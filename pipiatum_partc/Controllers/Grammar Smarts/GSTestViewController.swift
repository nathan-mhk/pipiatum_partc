//
//  GSTestViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 28/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class GSTestViewController: BasicMCViewController {

    @IBOutlet weak var gsMC: MCView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gsMC.setUpMC(senderTag: senderTag, componentName: "LBButton")
    }

}
