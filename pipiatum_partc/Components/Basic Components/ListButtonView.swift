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
    
    
    func addListButtons(buttons: Array<SubMenuItem>, btnHeight: CGFloat, superView: SubMenuStack) {
        var arrayIndex = 0
        for button in buttons {
//            subMenuButton.tag = button.ID
//
//            if arrayIndex % 2 == 1 {
//                subMenuButton.backgroundColor = UIColor(hexString: "195092")
//            }
//
//            subMenuButton.setTitle(button.Name, for: .normal)
//            subMenuButton.titleLabel?.textAlignment = .center
//            subMenuButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
//            subMenuButton.translatesAutoresizingMaskIntoConstraints = false
//            subMenuButton.heightAnchor.constraint(equalToConstant: CGFloat(btnHeight)).isActive = true
//
//            leftImg.image = UIImage(named: button.ImgName)
            
            superView.addArrangedSubview(self)
            print("added button \(button.ID)")
            
            arrayIndex += 1
        }
    }
    
    //Only appears when a wrong ANS is chosen
    func setRightImg() {
        UIView.animate(withDuration: 0.15, animations: {
            self.rightImg.image = UIImage(named: "incorrect")
        })
    }
    
    func setUpListButton(id: Int, title: String, imgName: String, btnHeight: CGFloat) {
        subMenuButton.tag = id
        if id % 2 == 1 {
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
