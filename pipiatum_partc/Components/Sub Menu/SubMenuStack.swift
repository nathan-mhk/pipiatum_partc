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
        //ListButtonView().addListButtons(buttons: buttons, btnHeight: btnHeight, superView: self)
        addListButtons(buttons: buttons)
        //addButtons(buttons: buttons)
    }
    
    //Set the height constraint of the subMenuStackView
    private func setStackHeight(buttons: Array<SubMenuItem>, stackHeight: NSLayoutConstraint) {
        let buttonCount = CGFloat(buttons.count)
        let totalSpacing = self.spacing * (buttonCount - 1.0)
        
        btnHeight = (self.frame.height - totalSpacing) / buttonCount
        btnHeight = btnHeight < 55.0 ? 55.0 : btnHeight
        btnHeight = btnHeight > 80.0 ? 80.0 : btnHeight
        
        let totalButtonsHeight = btnHeight * buttonCount
        stackHeight.constant = totalButtonsHeight + totalSpacing
    }
    
    //Add buttons into subMenuStackView
    private func addButtons(buttons: Array<SubMenuItem>) {
        var arrayIndex = 0
        for button in buttons {
            let subMenuButton = SubMenuButton.newButton()
            
            subMenuButton.tag = arrayIndex
            if arrayIndex % 2 == 1 {
                subMenuButton.backgroundColor = UIColor(hexString: "195092")
            }
            subMenuButton.setTitle(button.Name, for: .normal)
            //subMenuButton.setLeftImg(imgName: button.ImgName)
            subMenuButton.titleLabel?.textAlignment = .center
            subMenuButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            subMenuButton.translatesAutoresizingMaskIntoConstraints = false
            subMenuButton.heightAnchor.constraint(equalToConstant: CGFloat(btnHeight)).isActive = true
            
            self.addArrangedSubview(subMenuButton)
            arrayIndex += 1
        }
    }
    
    private func addListButtons(buttons: Array<SubMenuItem>) {
        var arrayIndex = 0
        for button in buttons {
            let listButton = ListButtonView()
            listButton.setUpListButton(id: button.ID, title: button.Name, imgName: button.ImgName, btnHeight: CGFloat(btnHeight))
            self.addArrangedSubview(listButton)
            arrayIndex += 1
        }
    }
}
