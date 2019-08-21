//
//  TestViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 28/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class TestViewController: BasicMCViewController, PopUpDelegate {

    @IBOutlet weak var testMC: MCView!
    @IBOutlet weak var PopUp: PopUp!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testMC.delegate = self
        currentType = ListBtnType.test
        testMC.type = currentType
        testMC.utilityBar.type = currentType
        mcView = testMC
        setUpMCView(utilBarName: "EggBar")
        //To be implemented: EggBar
        
        //Popup
        PopUp.delegate = self
        setUpNavBar()
        setUpPopUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateContentHeight(contentView: testMC.MCQuestion, height: testMC.MCQnHeight)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            updateContentHeight(contentView: self.testMC.MCQuestion, height: self.testMC.MCQnHeight)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TEST_RESULT" {
            if let destination =  segue.destination as? TestResultViewController {
                destination.msg = congratMsg()
                destination.marks = marks
                destination.total = totalNumOfQns
                destination.type = ListBtnType.test.rawValue
            }
        }
    }
    
    var isHome: Bool = false
    
    func setUpNavBar() {
        //Quit button
        self.navigationItem.hidesBackButton = true
        let backBtn = UIBarButtonItem(title: "Quit", style: .plain, target: self, action: #selector(showQuitPopUp))
        self.navigationItem.leftBarButtonItem = backBtn
        
        //Home Button
        self.navigationItem.rightBarButtonItem = nil
        setHomeButton(action: #selector(showHomePopUp))
    }
    
    func setUpPopUp() {
        view.sendSubviewToBack(PopUp)
        PopUp.YesBtn.isEnabled = false
        PopUp.NoBtn.isEnabled = false
        PopUp.alpha = 0
    }
    
    func backToMenu() {
        let viewControllers: [UIViewController] = self.navigationController?.viewControllers.reversed() ?? [UIViewController]()
        for vc in viewControllers {
            if vc .isKind(of: BasicSubMenuViewController.self) {
                self.navigationController?.popToViewController(vc, animated: true)
                break
            }
        }
    }
    
    func showPopUp() {
        toggleNavBtns()
        PopUp.toggleButtons()
        
        view.bringSubviewToFront(PopUp)
        testMC.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: MCAnimationDuration, animations: {
            self.PopUp.alpha = 1
        })
    }
    
    @objc func showQuitPopUp() {
        PopUp.isHome = false
        showPopUp()
    }
    
    @objc func showHomePopUp() {
        PopUp.isHome = true
        showPopUp()
    }
    
    func hidePopUp() {
        toggleNavBtns()
        PopUp.toggleButtons()
        
        UIView.animate(withDuration: MCAnimationDuration, animations: {
            self.PopUp.alpha = 0
        }, completion: {_ in
            self.view.sendSubviewToBack(self.PopUp)
            self.testMC.isUserInteractionEnabled = true
        })
    }
    
    func toggleNavBtns() {
        let alpha: CGFloat = self.navigationItem.rightBarButtonItem!.isEnabled ? 0.75 : 1
        UIView.animate(withDuration: MCAnimationDuration, animations: {
            
            self.navigationItem.leftBarButtonItem!.isEnabled = !self.navigationItem.leftBarButtonItem!.isEnabled
            self.navigationItem.rightBarButtonItem?.customView?.alpha = alpha
            self.navigationItem.rightBarButtonItem!.isEnabled = !self.navigationItem.rightBarButtonItem!.isEnabled
        })
    }
}
