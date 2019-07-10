//
//  ScriptFontButton.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 4/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class ScriptFontButton: ConfigButton {
    
    required init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func getKey() -> String {
        return AppConfig.scriptFontKey
    }
}
