//
//  AppConfig.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 4/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit
import CoreData

//enums
enum ListBtnType: String {
    case none
    case submenu
    
    //MC
    case gs = "grammar smart test"
    case practice
    case test
}

//Misc
let btnCornerRadius: CGFloat = 5

//SubMenu
let minSubMenuBtnHeight: CGFloat = 55
let maxSubMenuBtnHeight: CGFloat = 100

//MC
let numOf1MarkQn: Int = 1
let numOf2MarksQn: Int = 8
let numOf3MarksQn: Int = 1
let yellow: String = "FFFD72"
let green: String = "8BC45D"
let mcScoreThreshold: Float = 0.5
//The time delay before showing the next TestMC question
//Reduce its value if needed for debug use
let testMCDelay: TimeInterval = 3
//The duration of the overall MC UI elements (changing questions, changing choice, updating the color of choice, etc)
let MCAnimationDuration: TimeInterval = 0.3
//The duration of the alpha-changing animation of buttons
let BtnAnimationDuration: TimeInterval = MCAnimationDuration

//Settings
let stdFontKey: String = "stdFont"
let scriptFontKey: String = "scriptFont"

//Saving
let entityName: String = "Performance"
let qnCategory: String = "category"
let qnNumber: String = "qnNumber"
let totalTimes: String = "totalTimes"
let corrTimes: String = "corrTimes"
