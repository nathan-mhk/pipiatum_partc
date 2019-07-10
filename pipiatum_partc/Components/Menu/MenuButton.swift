//
//  MenuButton.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 27/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class MenuButton: BasicButtonComponent {
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
        setUpAlign()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpButton()
        setUpAlign()
    }
    
    func setUpAlign() {
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -30)
    }

}
