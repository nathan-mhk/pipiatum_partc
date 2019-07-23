//
//  ListButton.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 22/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class ListButton: BasicButtonComponent {
    
    override func setUpButton() {
        //Prevent multitouch
        isExclusiveTouch = true
        
        //White bold 16 text
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
    }
}
