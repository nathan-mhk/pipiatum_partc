//
//  SubMenuStack.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 8/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class SubMenuStack: UIStackView {
    
    //MARK: Initialization
    override required init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //Standard button height for all of the buttons in subMenu
    var btnHeight = CGFloat(60)
    
    //TODO: Change buttons type?
    func setUpButtonStack(buttons: Array<Any>, stackHeight: NSLayoutConstraint) {
        
        //cleanSubViews()
        setStackHeight(buttons: buttons, stackHeight: stackHeight)
        addButtons(buttons: buttons)
    }
    
    
    //MARK: Set Up Functions
    //Clean up existing subviews(buttons)
    private func cleanSubViews() {
        //Clean up existing subviews(buttons)
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    //Set the height constraint of the subMenuStackView
    //TODO: Change buttons type?
    private func setStackHeight(buttons: Array<Any>, stackHeight: NSLayoutConstraint) {
        let buttonCount = CGFloat(buttons.count)
        let totalSpacing = self.spacing * (buttonCount - 1.0)
        
        btnHeight = (self.frame.height - totalSpacing) / buttonCount
        btnHeight = btnHeight < 55.0 ? 55.0 : btnHeight
        btnHeight = btnHeight > 70.0 ? 70.0 : btnHeight
        
        let totalButtonsHeight = btnHeight * buttonCount
        stackHeight.constant = totalButtonsHeight + totalSpacing
    }
    
    //Add buttons into subMenuStackView
    private func addButtons(buttons: Array<Any>) {
        for button in buttons {
            //Probably just = BasicButtonComponent()
            let subMenuButton = SubMenuButton.newButton()
            
            //TODO: Change buttons type?
            subMenuButton.setTitle(button as? String, for: .normal)
            subMenuButton.titleLabel?.textAlignment = .center
            subMenuButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            subMenuButton.translatesAutoresizingMaskIntoConstraints = false
            subMenuButton.heightAnchor.constraint(equalToConstant: CGFloat(btnHeight)).isActive = true
            
            self.addArrangedSubview(subMenuButton)
        }
    }
    
}
