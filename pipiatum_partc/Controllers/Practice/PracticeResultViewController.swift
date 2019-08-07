//
//  PracticeResultViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 28/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class PracticeResultViewController: BasicResultViewController {

    @IBOutlet weak var result: ResultScreenView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        result.setUpResult(msg: msg, marks: marks, total: total, type: type)
        prepareNavBtn(home: false)
    }
    
    func prepareNavBtn(home: Bool) {
        if var vcCount = navigationController?.viewControllers.count {
            vcCount = home ? vcCount - 3 : vcCount - 2
            navigationController?.viewControllers.remove(at: vcCount)
        }
    }
}
