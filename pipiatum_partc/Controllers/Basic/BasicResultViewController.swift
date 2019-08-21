//
//  BasicResultViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 29/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class BasicResultViewController: BasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.
        setUpNavBar()
    }
    
    var msg = ""
    var marks = 0
    var total = 0
    var type = ""
    
    //MARK: Set Up Functions
    //Back button
    private func setUpNavBar() {
        self.navigationItem.hidesBackButton = true
        let backBtn = UIBarButtonItem(title: "Finish", style: .plain, target: self, action: #selector(backToMenu))
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    @objc func backToMenu() {
        let viewControllers: [UIViewController] = self.navigationController?.viewControllers.reversed() ?? [UIViewController]()
        for vc in viewControllers {
            if vc .isKind(of: BasicSubMenuViewController.self) {
                self.navigationController?.popToViewController(vc, animated: true)
                break
            }
        }
    }
}
