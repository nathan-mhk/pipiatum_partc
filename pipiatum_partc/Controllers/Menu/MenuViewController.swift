//
//  MenuViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 21/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Hide the navigatoin bar
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            if UIDevice.current.orientation.isLandscape {
                print("Landscape!")
            }
            else {
                print("Portrait!")
            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
    
}
