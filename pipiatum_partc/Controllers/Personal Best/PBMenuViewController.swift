//
//  PersonalBestViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 28/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class PBMenuViewController: BasicSubMenuViewController {
    
    @IBOutlet var pbMenu: SubMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pbMenu.id = "pb"
        setUpSubMenu(subMenu: pbMenu)
        linkViewController()
    }

    override func linkViewController() {
        let buttons = self.view.getAllSubViews() as [SubMenuButton]
        for button in buttons {
            button.addTarget(self, action: #selector(buttonSegue), for: .touchUpInside)
        }
    }
    
    @objc override func buttonSegue() {
        subMenuButtonSegue(segueID: "PERSONALBEST", viewController: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PERSONALBEST" {
            if let destination = segue.destination as? PBViewController {
                print("Going to PB View!")
            }
        }
    }
    
}
