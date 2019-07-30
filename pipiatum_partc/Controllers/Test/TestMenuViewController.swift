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
        testMenu.id = "test"
        setUpSubMenu(subMenu: testMenu)
        linkViewController()
    }
    
    override func linkViewController() {
        let buttons = self.view.getAllSubViews() as [ListButton]
        for button in buttons {
            button.addTarget(self, action: #selector(buttonSegue(sender:)), for: .touchUpInside)
        }
    }
    
    @objc override func buttonSegue(sender: ListButton) {
        subMenuButtonSegue(segueID: "TEST", viewController: self, sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TEST" {
            if let destination = segue.destination as? TestViewController {
                if let subMenuButton = sender as? ListButton {
                    print("Going to Test View from button \(subMenuButton.tag) (\(buttons[subMenuButton.tag].Name))")
                    destination.senderTag = subMenuButton.tag
                }
            }
        }
    }

}
