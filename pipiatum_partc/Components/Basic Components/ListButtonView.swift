//
//  ListButtonView.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 22/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class ListButtonView: UIView {
    
    @IBOutlet weak var subMenuButton: SubMenuButton!
    @IBOutlet weak var leftImg: UIImageView!
    @IBOutlet weak var rightImg: UIImageView!
    
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        setUpComponent(componentName: "ListButton", superView: self)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpComponent(componentName: "ListButton", superView: self)
    }
    
    //Only appears when a wrong ANS is chosen
    func setRightImg() {
        UIView.animate(withDuration: 0.15, animations: {
            self.rightImg.image = UIImage(named: "incorrect")
        })
    }
    
    func setUpSubMenu(id: Int, title: String, imgName: String, btnHeight: CGFloat) {
        subMenuButton.tag = id
        if id % 2 == 0 {
            //Light
            subMenuButton.backgroundColor = UIColor(hexString: "1955A2")
        }
        else {
            //Slightly Dark
            subMenuButton.backgroundColor = UIColor(hexString: "195092")
        }
        
        subMenuButton.setTitle(title, for: .normal)
        subMenuButton.titleLabel?.textAlignment = .center
        subMenuButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        leftImg.image = UIImage(named: imgName)
        subMenuButton.translatesAutoresizingMaskIntoConstraints = false
        subMenuButton.heightAnchor.constraint(equalToConstant: btnHeight).isActive = true
    }
 
}
