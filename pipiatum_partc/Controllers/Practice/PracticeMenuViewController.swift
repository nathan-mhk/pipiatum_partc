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

        // Do any additional setup after loading the view.
        practiceMenu.id = "practice"
        setUpSubMenu(subMenu: practiceMenu, readjust: false)
        //TODO:
        //Pass the plist to practiceMenu.setUpSubMenu
        
    }

    @IBAction func button_clicked(_ sender: SubMenuButton) {
        self.performSegue(withIdentifier: "PRACTICE", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PRACTICE" {
            if let destination = segue.destination as? PracticeViewController {
                print("Going to Practice View!")
            }
        }
    }

}
