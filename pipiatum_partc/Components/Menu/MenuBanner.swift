//
//  MenuBanner.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 21/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class MenuBanner: UIView {
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        setUpComponent(componentName: "MenuBanner", superView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpComponent(componentName: "MenuBanner", superView: self)
    }
    
}
