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
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
