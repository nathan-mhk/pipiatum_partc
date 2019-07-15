//
//  buttonSegue.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 11/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

func subMenuButtonSegue(segueID: String, viewController: BasicSubMenuViewController, sender: SubMenuButton) {
    viewController.performSegue(withIdentifier: segueID, sender: sender)
}
