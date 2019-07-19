//
//  PracticeViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 28/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class PracticeViewController: BasicMCViewController {

    @IBOutlet weak var practiceMC: MCView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        practiceMC.setUpMC(senderTag: senderTag, componentName: "PracticeButtons")
        
    }
    
    
}
