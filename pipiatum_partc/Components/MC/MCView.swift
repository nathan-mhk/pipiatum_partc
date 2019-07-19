//
//  MCView.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 10/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class MCView: UIView {
    
    @IBOutlet weak var utilityBar: UtilityBar!
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        setUpComponent(componentName: "MCView", superView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpComponent(componentName: "MCView", superView: self)
    }
    
    func setUpMC(senderTag: Int?, componentName: String) {
        utilityBar.setUtilBar(componentName: componentName)
    }

}
