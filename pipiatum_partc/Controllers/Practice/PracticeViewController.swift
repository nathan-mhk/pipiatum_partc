//
//  PracticeViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 28/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class PracticeViewController: BasicMCViewController {

    @IBOutlet weak var practiceMC: MCView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        practiceMC.delegate = self
        practiceMC.utilityBar.delegate = self
        currentType = .practice
        practiceMC.type = currentType
        practiceMC.utilityBar.type = currentType
        mcView = practiceMC
        setUpMCView(utilBarName: "PracticeButtons")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateContentHeight(contentView: practiceMC.MCQuestion, height: practiceMC.MCQnHeight)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            updateContentHeight(contentView: self.practiceMC.MCQuestion, height: self.practiceMC.MCQnHeight)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PRACTICE_RESULT" {
            if let destination = segue.destination as? PracticeResultViewController {
                destination.msg = congratMsg()
                destination.marks = marks
                destination.total = totalNumOfQns
                destination.type = ListBtnType.practice.rawValue
                self.navigationItem.title = "Practice"
            }
        }
    }
    /*
    @objc override func backToMenu(sender: UIBarButtonItem) {
        print("hi")
        self.performSegue(withIdentifier: "PRACTICE_MENU", sender: sender)
        print("YO")
    }
    
    @objc func back() {
        print("BYE")
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
    }*/
}
