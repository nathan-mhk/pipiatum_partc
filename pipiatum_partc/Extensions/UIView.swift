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
    
}
