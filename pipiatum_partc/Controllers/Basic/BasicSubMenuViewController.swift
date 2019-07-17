//
//  BasicSubMenuViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 9/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class BasicSubMenuViewController: BasicViewController {
    
    @IBInspectable var itemsPlistName: String? {
        didSet {
            #if !TARGET_INTERFACE_BUILDER
                loadPlistData()
            #endif
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //Array of sub menu items, containing the attributes of each sub menu item (ID, Name, Dir)
    //Will be modified inside loadPlistData
    var buttons: Array<SubMenuItem> = Array()
    
    //MARK: Set Up Functions
    //Load plist in buttons array
    private func loadPlistData() {
        if let plistName = self.itemsPlistName {
            if let plist = PlistUtil.load(named: plistName) {
                if let subMenuContents = plist.object(forKey: "MenuItems") as? [NSDictionary] {
                    for subMenuContent in subMenuContents {
                        if let subMenuItem = SubMenuItem(menuContent: subMenuContent) {
                            buttons.append(subMenuItem)
                        }
                    }
                }
            }
        }
    }
    
    func setUpSubMenu(subMenu: SubMenu) {
        var imgName: String = ""
        
        var subMenuButtons: Array<String> = Array()
        for item in buttons {
            subMenuButtons.append(item.Name)
        }
        
        switch subMenu.id {
        case "practice":
            //To be replaced by practice menu sticker
            imgName = "SettingSticker"
            break
        case "test":
            imgName = "SettingSticker"
            break
        case "pb":
            imgName = "SettingSticker"
            break
        default:
            break
        }
        subMenu.setImage(imgName: imgName)
        subMenu.setBtnStack(buttons: subMenuButtons)
    }
    
    //MARK: MUST OVERRIDE
    func linkViewController() {
    }
    
    @objc func buttonSegue(sender: SubMenuButton) {
    }
    
}
