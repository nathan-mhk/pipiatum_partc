//
//  MCView.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 10/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class MCView: UIView {

    //MARK: Initialization
    override required init(frame: CGRect) {
        super.init(frame: frame)
        SetUpComponent(componentName: "MCView", superView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        SetUpComponent(componentName: "MCView", superView: self)
    }

}