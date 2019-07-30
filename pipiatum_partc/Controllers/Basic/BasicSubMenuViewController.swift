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
        guard let plistName = self.itemsPlistName else {
            print("Plist Name Not Found")
            return
        }
        guard let plist = PlistUtil.load(named: plistName) else {
            return
        }
        guard let subMenuContents = plist.object(forKey: "MenuItems") as? [NSDictionary] else {
            print("Failed To Load Plist As [NSDictionary]")
            return
        }
        
        for subMenuContent in subMenuContents {
            if let subMenuItem = SubMenuItem(menuContent: subMenuContent) {
                buttons.append(subMenuItem)
            }
        }
        
    }
    
    func setUpSubMenu(subMenu: SubMenu) {
        var imgName: String = ""
        
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
        subMenu.setBtnStack(buttons: buttons)
    }
    
    //MARK: MUST OVERRIDE
    func linkViewController() {
    }
    
    @objc func buttonSegue(sender: ListButton) {
    }
    
    func subMenuButtonSegue(segueID: String, viewController: BasicSubMenuViewController, sender: ListButton) {
        viewController.performSegue(withIdentifier: segueID, sender: sender)
    }
    
}
