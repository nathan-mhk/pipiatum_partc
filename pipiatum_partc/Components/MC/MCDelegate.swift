//
//  MCDelegate.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 25/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

protocol MCDelegate: class {
    var firstMCSelected: Bool {get set}
    var mcBtnPressed: Bool {get set}
    var showBtnPressed: Bool {get set}
    var checkBtnPressed: Bool {get set}
    var nextBtnPressed: Bool {get set}
    var isEnd: Bool {get set}
    
    func updateView()
    func showAns(showFB: Bool)
    func checkAns()
    func nextMC()
    func endMC(sender: UtilityButton)
}

