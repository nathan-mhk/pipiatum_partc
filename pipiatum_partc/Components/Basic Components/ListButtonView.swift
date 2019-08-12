//
//  ListButtonView.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 22/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class ListButtonView: UIView {
    
    @IBOutlet weak var listButton: ListButton!
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
    
    //MARK: MC
    weak var delegate: MCDelegate?
    
    //Only appears when a wrong ANS is chosen
    func setRightImg(show: Bool) {
        let alpha: CGFloat = show ? 1 : 0
        UIView.animate(withDuration: MCAnimationDuration, animations: {
            self.rightImg.alpha = alpha
        })
    }
    
    //Practice: allow changing MC Choice
    //Test MC: don't allow changing MC Choice
    //GS MC: TBC
    @IBAction func MCButton(_ sender: ListButton) {
        if sender.type != .submenu {
            toggleSelection(setOriginal: false)
            sender.chosen = true    //Preserved, only reset in updateView() (When another MCBtn is pressed) and in nextMC()
        }
        
        if sender.type == .gs {
            //TBC
        }
        
        if sender.type == .practice {
            //Mark the button pressed momentarily, notify updateView() about which MCBtn is pressed
            //Prevent the button BEING RESET by updateView()
            sender.isPressed = true
            
            //Notify the controller that a MCButton is pressed
            delegate?.mcBtnPressed = true
            
            delegate?.updateView()      //update other MC buttons and utility bar buttons
            UIView.animate(withDuration: MCAnimationDuration, animations: {
                sender.backgroundColor = UIColor(hexString: "FFFD72")   //Yellow
            })
            
            sender.isPressed = false
            delegate?.mcBtnPressed = false
            delegate?.firstMCSelected = true   //Only reset in nextMC()
        }
        
        if sender.type == .test {
            delegate?.checkAns()
        }
    }
    
    //MARK: SubMenu
    func setUpSubMenu(id: Int, title: String, imgName: String, btnHeight: CGFloat) {
        listButton.tag = id
        listButton.type = .submenu
        setUpButton(btnNum: id, title: title, isMC: false)
        
        listButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 75, bottom: 0, right: 35)
        leftImg.image = UIImage(named: imgName)
        listButton.translatesAutoresizingMaskIntoConstraints = false
        listButton.heightAnchor.constraint(equalToConstant: btnHeight).isActive = true
    }
    
    //MARK: Util Function
    //Set up basic attributes and alternating colour
    func setUpButton(btnNum: Int, title: String, isMC: Bool) {
        if btnNum % 2 == 0 {
            //Light
            listButton.backgroundColor = UIColor(hexString: "1955A2")
        }
        else {
            //Slightly Dark
            listButton.backgroundColor = UIColor(hexString: "195092")
        }
        listButton.originalColor = listButton.backgroundColor!
        listButton.titleLabel?.textAlignment = .center
        listButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        rightImg.alpha = 0.0
        
        if isMC {
            listButton.originalHtmlTitle = gethtmlWhiteString(string: title, isBold: true)
            toggleSelection(setOriginal: true)
        } else {
            listButton.setTitleColor(.white, for: .normal)
            listButton.setTitle(title, for: .normal)
        }
    }
    
    func toggleSelection(setOriginal: Bool) {
        if setOriginal {
            let attrString = convertToAttrString(string: listButton.originalHtmlTitle)
            listButton.setAttributedTitle(attrString, for: .normal)
        } else {
            if let currentTitle = listButton.currentAttributedTitle as? NSMutableAttributedString {
                currentTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSMakeRange(0, currentTitle.length))
            }
        }
    }
}
