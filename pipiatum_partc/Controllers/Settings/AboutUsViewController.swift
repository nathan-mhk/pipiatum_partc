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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateContentHeight(contentView: aboutUsContentView, height: contentViewHeight)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            updateContentHeight(contentView: self.aboutUsContentView, height: self.contentViewHeight)
        }
    }
}
