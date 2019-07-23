//
//  MCChoice.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 23/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class MCChoice: UIStackView {
    override required init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    //TODO:
    //Load  CorrectAns, Dis1 and Dis2
    //Randomly put into 3 different buttons
    //Use addArrangedSubview to add the button, in alternating color
}
