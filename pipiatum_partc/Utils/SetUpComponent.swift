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
    if let component = Bundle.main.loadNibNamed(componentName, owner: superView, options: nil)?.first as? UIView {
        if let viewController = superView as? UIViewController {
            viewController.view.addSubview(component)
            component.frame = viewController.view.bounds
        }
        superView.addSubview(component)
        component.frame = superView.bounds
    }
    
}

func updateContentHeight(contentView: UIView, height: NSLayoutConstraint) {
    let viewRect = contentView.frame
    var minY = viewRect.minY
    var maxY = minY
    
    for subview in contentView.subviews {
        let rect = subview.frame
        minY = min(minY, rect.minY)
        maxY = max(maxY, rect.maxY)
    }
    
    height.constant = abs(ceil(maxY - minY))
}

