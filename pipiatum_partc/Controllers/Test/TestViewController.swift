//
//  TestViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 28/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class TestViewController: BasicMCViewController {

    @IBOutlet weak var testMC: MCView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testMC.setUpMC(senderTag: senderTag, componentName: "TestMCUtil")
    }
    
}
