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
    var Dir: String = ""
    
    init?(menuContent: NSDictionary) {
        let id = menuContent.object(forKey: "ID") as? Int
        let name = menuContent.object(forKey: "Name") as? String
        let dir = menuContent.object(forKey: "Directory") as? String
        
        if id != nil && name != nil && dir != nil {
            self.ID = id!
            self.Name = name!
            self.Dir = dir!
        }
        else {
            return nil
        }
    }
}
