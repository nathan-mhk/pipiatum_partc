//
//  SubMenuButton.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 8/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class SubMenuButton: ListButton {
    
    class func newButton() -> SubMenuButton {
        let newButton = SubMenuButton.init(type: .system)
        newButton.setUpButton()
        return newButton
    }
}
