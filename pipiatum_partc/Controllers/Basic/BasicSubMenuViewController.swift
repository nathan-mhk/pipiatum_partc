//
//  BasicSubMenuViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 9/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class BasicSubMenuViewController: BasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setUpSubMenu(subMenu: SubMenu, readjust: Bool) {
        var imgName: String = ""
        
        //TODO: plist array, change buttons type?
        var buttons: Array<Any> = Array()
        
        switch subMenu.id {
        case "practice":
            //To be replaced by practice menu sticker
            imgName = "SettingSticker"
            buttons = practiceArray
            break
        case "test":
            imgName = "SettingSticker"
            buttons = testArray
            break
        case "pb":
            imgName = "SettingSticker"
            buttons = pbArray
            break
        default:
            break
        }
        
        if !readjust {
            subMenu.setImage(imgName: imgName)
        }
        subMenu.setBtnStack(buttons: buttons)
    }
    
    
    //MARK: MUST OVERRIDE
    func linkViewController() {
    }
    
    @objc func buttonSegue() {
    }
}
