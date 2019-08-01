//
//  BasicButtonComponent.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 26/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class BasicButtonComponent: UIButton {

    override required init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpButton()
    }
    
    func setUpButton() {
        //Prevent multitouch
        isExclusiveTouch = true
        
        //Rounding the corners
        layer.cornerRadius = btnCornerRadius
        
        //BGColor: #103B72, White bold 16 text
        backgroundColor = UIColor(hexString: "103B72")
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
    }
    
    func changeState() {
        self.isEnabled = !self.isEnabled
        self.setAlpha()
    }
    
    func setAlpha() {
        let alpha: CGFloat = self.isEnabled ? 1.0 : 0.5
        UIView.animate(withDuration: BtnAnimationDuration, animations: {
            self.alpha = alpha
        })
    }
}
