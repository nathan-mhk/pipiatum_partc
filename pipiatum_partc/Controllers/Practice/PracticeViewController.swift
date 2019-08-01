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
        practiceMC.delegate = self
        practiceMC.utilityBar.delegate = self
        currentType = .practice
        practiceMC.type = currentType
        practiceMC.utilityBar.type = currentType
        mcView = practiceMC
        setUpMCView(utilBarName: "PracticeButtons")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PRACTICE_RESULT" {
            if let destination = segue.destination as? PracticeResultViewController {
                destination.msg = congratMsg()
                destination.marks = marks
                destination.total = totalNumOfQns
                destination.type = ListBtnType.practice.rawValue
            }
        }
    }
}
