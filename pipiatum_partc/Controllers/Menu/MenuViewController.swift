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
        // Do any additional setup after loading the view.
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
