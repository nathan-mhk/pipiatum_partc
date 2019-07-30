//
//  UIView.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 11/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

extension UIView {
    
    //Reference: https://stackoverflow.com/a/47282118
    //Usage:
    //let allLabels = simpleView.getAllSubViews() as [UILabel]
    class func getAllSubviews<T: UIView>(from parentView: UIView) -> [T] {
        return parentView.subviews.flatMap { subView -> [T] in
            var result = getAllSubviews(from: subView) as [T]
            if let view = subView as? T { result.append(view) }
            return result
        }
    }
    
    func getAllSubViews<T: UIView>() -> [T] {
        return UIView.getAllSubviews(from: self) as [T]
    }
    //Reference end
    
    //Reference: https://stackoverflow.com/a/27645516
    //Usage:
    //label.fadeTransition(0.4)
    //label.text = "text"
    func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
