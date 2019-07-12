//
//  SetUpComponent.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 21/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

func setUpComponent(componentName: String, superView: AnyObject) {
    
    //Load the component with the name <componentName> with loadNibNamed (return an array of UIView)
    //Take the first item of the [UIView] and addSubView and set constraints (fill up the superView)
    if let component = Bundle.main.loadNibNamed(componentName, owner: superView, options: nil) as? [UIView], let firstComponent = component.first {
        if let viewController = superView as? UIViewController {
            viewController.view.addSubview(firstComponent)
            firstComponent.frame = viewController.view.bounds
        }
        superView.addSubview(firstComponent)
        firstComponent.frame = superView.bounds
    }
}
