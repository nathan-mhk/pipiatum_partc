//
//  SubMenuButton.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 8/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class SubMenuButton: BasicButtonComponent {
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpButton()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
