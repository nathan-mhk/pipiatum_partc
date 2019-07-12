//
//  PersonalBest.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 27/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class PersonalBest: UIView {
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        SetUpComponent(componentName: "PersonalBestView", superView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        SetUpComponent(componentName: "PersonalBestView", superView: self)
    }

}
