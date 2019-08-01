//
//  SubMenuStack.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 8/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class SubMenuStack: UIStackView {

    override required init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //Standard button height for all of the buttons in subMenu
    var btnHeight = CGFloat(60)
    
    //MARK: Set Up Functions
    func setUpButtonStack(buttons: Array<SubMenuItem>, stackHeight: NSLayoutConstraint) {
        setStackHeight(buttons: buttons, stackHeight: stackHeight)
        addListButtons(buttons: buttons)
    }
    
    //Set the height constraint of the subMenuStackView
    private func setStackHeight(buttons: Array<SubMenuItem>, stackHeight: NSLayoutConstraint) {
        let buttonCount = CGFloat(buttons.count)
        
        btnHeight = self.frame.height / buttonCount
        btnHeight = btnHeight < minSubMenuBtnHeight ? minSubMenuBtnHeight : btnHeight
        btnHeight = btnHeight > maxSubMenuBtnHeight ? maxSubMenuBtnHeight : btnHeight
        
        stackHeight.constant = btnHeight * buttonCount
    }
    
    //Add buttons into subMenuStackView
    private func addListButtons(buttons: Array<SubMenuItem>) {
        for button in buttons {
            let listButton = ListButtonView()
            listButton.setUpSubMenu(id: button.ID, title: button.Name, imgName: button.ImgName, btnHeight: CGFloat(btnHeight))
            self.addArrangedSubview(listButton)
        }
    }
}
