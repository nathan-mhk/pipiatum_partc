//
//  UtilityBar.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 18/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class UtilityBar: UIView {

    override required init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setUtilBar(componentName: String) {
        setUpComponent(componentName: componentName, superView: self)
    }

}
