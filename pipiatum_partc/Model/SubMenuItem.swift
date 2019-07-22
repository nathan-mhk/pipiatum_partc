//
//  SubMenuItemt.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 12/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class SubMenuItem {
    var ID: Int = -1
    var Name: String = ""
    var ImgName: String = ""
    
    init?(menuContent: NSDictionary) {
        if let id = menuContent.object(forKey: "ID") as? Int,
            let name = menuContent.object(forKey: "Name") as? String,
            let imgName = menuContent.object(forKey: "ImgName") as? String {
            
            self.ID = id
            self.Name = name
            self.ImgName = imgName
        }
        else {
            return nil
        }
    }
}
