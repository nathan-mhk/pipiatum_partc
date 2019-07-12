//
//  ResultScreenView.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 10/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class ResultScreenView: UIView {

    override required init(frame: CGRect) {
        super.init(frame: frame)
        setUpComponent(componentName: "ResultScreenView", superView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpComponent(componentName: "ResultScreenView", superView: self)
    }

}
