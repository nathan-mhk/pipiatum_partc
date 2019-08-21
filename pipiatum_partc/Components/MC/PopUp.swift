//
//  PopUp.swift
//  pipiatum_partc
//
//  Created by Nathan on 20/8/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class PopUp: UIView {
    
    @IBOutlet weak var YesBtn: UIButton!
    @IBOutlet weak var NoBtn: UIButton!
    
    var isHome: Bool = false
    weak var delegate: PopUpDelegate?
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        setUpComponent(componentName: "PopUp", superView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpComponent(componentName: "PopUp", superView: self)
    }
    
    func toggleButtons() {
        YesBtn.isEnabled = !YesBtn.isEnabled
        NoBtn.isEnabled = !NoBtn.isEnabled
    }
    
    @IBAction func ConfirmQuit(_ sender: UIButton) {
        if isHome {
            delegate!.backToHome()
        } else {
            delegate!.backToMenu()
        }
    }
    
    @IBAction func CancelQuit(_ sender: UIButton) {
        delegate!.hidePopUp()
    }
    
}
