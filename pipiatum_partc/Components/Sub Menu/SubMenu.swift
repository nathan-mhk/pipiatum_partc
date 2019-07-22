//
//  SubMenu.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 26/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class SubMenu: UIView {
    
    @IBOutlet weak var subMenuImage: UIImageView!
    @IBOutlet weak var subMenuStackView: SubMenuStack!
    @IBOutlet weak var subMenuStackHeight: NSLayoutConstraint!
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        setUpComponent(componentName: "SubMenu", superView: self)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpComponent(componentName: "SubMenu", superView: self)
    }
    
    var id = ""
    
    //MARK: Set Up Functions
    //Set up the image of the subMenu by the given name
    func setImage(imgName: String) {
        subMenuImage.image = UIImage(named: imgName)
    }
    
    func setBtnStack(buttons: Array<SubMenuItem>) {
        subMenuStackView.setUpButtonStack(buttons: buttons, stackHeight: subMenuStackHeight)
    }
}
