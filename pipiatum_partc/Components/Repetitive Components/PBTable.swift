//
//  PBTable.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 11/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class PBTable: UIView {

    //MARK: Initialization
    override required init(frame: CGRect) {
        super.init(frame: frame)
        SetUpComponent(componentName: "pbTable", superView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        SetUpComponent(componentName: "pbTable", superView: self)
    }

}
