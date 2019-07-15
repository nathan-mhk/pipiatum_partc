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
    func setUpButtonStack(buttons: Array<String>, stackHeight: NSLayoutConstraint) {
        
        //cleanSubViews()
        setStackHeight(buttons: buttons, stackHeight: stackHeight)
        addButtons(buttons: buttons)
    }
    
    //Clean up existing subviews(buttons)
    private func cleanSubViews() {
        //Clean up existing subviews(buttons)
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    //Set the height constraint of the subMenuStackView
    private func setStackHeight(buttons: Array<String>, stackHeight: NSLayoutConstraint) {
        let buttonCount = CGFloat(buttons.count)
        let totalSpacing = self.spacing * (buttonCount - 1.0)
        
        btnHeight = (self.frame.height - totalSpacing) / buttonCount
        btnHeight = btnHeight < 55.0 ? 55.0 : btnHeight
        btnHeight = btnHeight > 70.0 ? 70.0 : btnHeight
        
        let totalButtonsHeight = btnHeight * buttonCount
        stackHeight.constant = totalButtonsHeight + totalSpacing
    }
    
    //Add buttons into subMenuStackView
    private func addButtons(buttons: Array<String>) {
        var arrayIndex = 0
        for button in buttons {
            //Probably just = BasicButtonComponent()
            let subMenuButton = SubMenuButton.newButton()
            
            subMenuButton.tag = arrayIndex
            subMenuButton.setTitle(button, for: .normal)
            subMenuButton.titleLabel?.textAlignment = .center
            subMenuButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            subMenuButton.translatesAutoresizingMaskIntoConstraints = false
            subMenuButton.heightAnchor.constraint(equalToConstant: CGFloat(btnHeight)).isActive = true
            
            self.addArrangedSubview(subMenuButton)
            arrayIndex += 1
        }
    }
    
}
