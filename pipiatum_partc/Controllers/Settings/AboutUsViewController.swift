//
//  AboutUsViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 28/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class AboutUsViewController: BasicViewController {
    
    @IBOutlet weak var aboutUsContentView: UIView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateContentHeight()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self.updateContentHeight()
        }
    }
    

    private func computeContentHeight() -> CGFloat {
        let viewRect = aboutUsContentView.frame
        var minY = viewRect.minY
        var maxY = minY
        
        for subview in aboutUsContentView.subviews {
            let rect = subview.frame
            minY = min(minY, rect.minY)
            maxY = max(maxY, rect.maxY)
        }
        
        return abs(ceil(maxY - minY))
    }
    
    private func updateContentHeight() {
        contentViewHeight.constant = computeContentHeight()
    }

}
