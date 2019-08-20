//
//  BasicViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 28/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {
    
    var heightAnchor: NSLayoutDimension {
        return self.navigationItem.rightBarButtonItem!.customView!.heightAnchor
    }
    
    var widthAnchor: NSLayoutDimension {
        return self.navigationItem.rightBarButtonItem!.customView!.widthAnchor
    }
    
    var heightConstraint = NSLayoutConstraint()
    var widthConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "1955A2")
        setHomeButton()
    }
    
    func setHomeButton() {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "home_icon"), for: .normal)
        btn.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
        
        let homeBtn = UIBarButtonItem(customView: btn)
        self.navigationItem.rightBarButtonItem = homeBtn
        setSize(isUpdate: false)
    }
    
    func setSize(isUpdate: Bool) {
        var btnHeight = 0.68 * self.navigationController!.navigationBar.frame.size.height
        btnHeight = max(btnHeight, 24)
        
        if isUpdate {
            heightConstraint.isActive = false
            widthConstraint.isActive = false
        }
        heightConstraint = heightAnchor.constraint(equalToConstant: btnHeight)
        widthConstraint = widthAnchor.constraint(equalToConstant: btnHeight)
        heightConstraint.isActive = true
        widthConstraint.isActive = true
    }
    
    @objc func backToHome() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self.setSize(isUpdate: true)
            UIView.animate(withDuration: MCAnimationDuration, animations: {
                self.navigationItem.rightBarButtonItem?.customView?.layoutIfNeeded()
            })
        }
    }
}
