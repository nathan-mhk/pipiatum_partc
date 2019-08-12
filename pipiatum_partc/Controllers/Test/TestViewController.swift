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
        testMC.delegate = self
        currentType = .test
        testMC.type = currentType
        testMC.utilityBar.type = currentType
        mcView = testMC
        setUpMCView(utilBarName: "EggBar")
        //To be implemented: EggBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateContentHeight(contentView: testMC.MCQuestion, height: testMC.MCQnHeight)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            updateContentHeight(contentView: self.testMC.MCQuestion, height: self.testMC.MCQnHeight)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TEST_RESULT" {
            if let destination =  segue.destination as? TestResultViewController {
                destination.msg = congratMsg()
                destination.marks = marks
                destination.total = totalNumOfQns
                destination.type = ListBtnType.test.rawValue
                self.navigationItem.title = "Test"
            }
        }
    }
    
}
