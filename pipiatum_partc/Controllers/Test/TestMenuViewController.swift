//
//  TestMenuViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 28/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class TestMenuViewController: BasicSubMenuViewController {

    @IBOutlet var testMenu: SubMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        testMenu.id = "test"
        setUpSubMenu(subMenu: testMenu, readjust: false)
        linkViewController()
    }
    
    override func linkViewController() {
        let buttons = self.view.getAllSubViews() as [SubMenuButton]
        for button in buttons {
            button.addTarget(self, action: #selector(buttonSegue), for: .touchUpInside)
        }
    }
    
    @objc override func buttonSegue() {
        subMenuButtonSegue(segueID: "TEST", viewController: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TEST" {
            if let destination = segue.destination as? TestViewController {
                print("Going to Test View!")
            }
        }
    }
}
