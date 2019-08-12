//
//  ListButton.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 22/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

enum ListBtnType: String {
    case none
    case submenu
    
    //MC
    case gs = "grammar smart test"
    case practice
    case test
}

class ListButton: BasicButtonComponent {
    
    var type: ListBtnType = ListBtnType.none
    var isPressed: Bool = false
    var chosen: Bool = false
    var originalColor: UIColor = .clear
    var originalHtmlTitle: String = ""
    
    override func setUpButton() {
        //Prevent multitouch
        isExclusiveTouch = true
        
        //White bold 16 text
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
    }
}
