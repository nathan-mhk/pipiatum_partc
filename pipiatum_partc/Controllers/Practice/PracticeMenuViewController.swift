//
//  PracticeMenuViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 28/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class PracticeMenuViewController: BasicSubMenuViewController {

    @IBOutlet var practiceMenu: SubMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        practiceMenu.id = "practice"
        setUpSubMenu(subMenu: practiceMenu)
        linkViewController()
    }
    
    override func linkViewController() {
        let buttons = self.view.getAllSubViews() as [ListButton]
        for button in buttons {
            button.addTarget(self, action: #selector(buttonSegue(sender:)), for: .touchUpInside)
        }
    }
    
    @objc override func buttonSegue(sender: ListButton) {
        subMenuButtonSegue(segueID: "PRACTICE", viewController: self, sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PRACTICE" {
            if let destination = segue.destination as? PracticeViewController {
                if let subMenuButton = sender as? ListButton {
                    print("\(buttons[subMenuButton.tag].Name)")
                    destination.senderTag = subMenuButton.tag
                }
            }
        }
    }

}
