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
    let btnHeight = 60
    
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
        let totalSpacing = self.spacing * CGFloat(buttons.count - 1)
        let totalButtonsHeight = CGFloat(btnHeight * buttons.count)
        stackHeight.constant = totalButtonsHeight + totalSpacing
    }
    
    
    //Add buttons into subMenuStackView
    private func addButtons(buttons: Array<Any>) {
        for button in buttons {
            //Probably just = BasicButtonComponent()
            let subMenuButton = SubMenuButton()
            
            //TODO: Change buttons type?
            subMenuButton.setTitle(button as? String, for: .normal)
            subMenuButton.titleLabel?.textAlignment = .center
            subMenuButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            subMenuButton.translatesAutoresizingMaskIntoConstraints = false
            subMenuButton.heightAnchor.constraint(equalToConstant: CGFloat(btnHeight)).isActive = true
            linkToVC(button: subMenuButton)
            
            self.addArrangedSubview(subMenuButton)
        }
    }
    
    private func linkToVC(button: SubMenuButton) {
        //TODO
        button.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: .touchUpInside)
    }
    
}
