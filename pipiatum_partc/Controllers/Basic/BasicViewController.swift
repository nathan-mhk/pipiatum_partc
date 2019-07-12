//
//  BasicViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 28/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "1955A2")
    }
    
    func setUpComponent(componentName: String, superView: UIViewController) {
        //Load the component with the name <componentName> with loadNibNamed (return an array of UIView)
        //Take the first item of the [UIView] and addSubView and set constraints (fill up the superView)
        if let component = Bundle.main.loadNibNamed(componentName, owner: superView, options: nil) as? [UIView], let firstComponent = component.first {
            superView.view.addSubview(firstComponent)
            firstComponent.frame = superView.view.bounds
        }
    }
}
