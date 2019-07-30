//
//  UtilityBar.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 18/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class UtilityBar: UIView {
    
    @IBOutlet weak var LBButton: UtilityButton!
    @IBOutlet weak var showBtn: UtilityButton!
    @IBOutlet weak var checkBtn: UtilityButton!
    @IBOutlet weak var nextBtn: UtilityButton!
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        //Both will be disabled initially
        checkBtn.changeState()
        nextBtn.changeState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    weak var delegate: MCDelegate?
    
    func initUtilBar() {
        //Initially: show = T, check = F, next = F
        checkBtn.changeState()
        nextBtn.changeState()
    }
   
    //GS
    @IBAction func addLB(_ sender: UtilityButton) {
        //TBC
    }
    
    //Practice
    @IBAction func showAns(_ sender: UtilityButton) {
        delegate?.firstMCSelected = true
        delegate?.showBtnPressed = true
        delegate?.checkBtnPressed = false
        delegate?.nextBtnPressed = false
        delegate?.updateView()
        delegate?.showAns(showFB: true)
    }
    
    //Enabled only when MCSelected = T
    @IBAction func checkAns(_ sender: UtilityButton) {
        delegate?.showBtnPressed = false
        delegate?.checkBtnPressed = true
        delegate?.nextBtnPressed = false
        delegate?.updateView()
        delegate?.checkAns()
    }
    
    @IBAction func nextQn(_ sender: UtilityButton) {
        delegate?.showBtnPressed = false
        delegate?.checkBtnPressed = false
        delegate?.nextBtnPressed = true
        if !delegate!.isEnd {
            delegate!.nextMC()
        }
        else {
            delegate!.endMC(sender: sender)
        }
    }
    
    func updateView() {
        //If T, show = F, check = T, next = F
        if !delegate!.firstMCSelected {
            showBtn.changeState()       //Disabled
            checkBtn.changeState()      //Enabled
            //nextBtn keep disabled
        }
        //If T, show = F, check = F, next = T
        if delegate!.showBtnPressed {
            showBtn.changeState()       //Disabled
            nextBtn.changeState()       //Enabled
            //checkBtn keep disabled
        }
        //If T, show = F, check = F, next = T
        if delegate!.checkBtnPressed {
            checkBtn.changeState()      //Disabled
            nextBtn.changeState()       //Enabled
            //showBtn keep disabled
        }
        //If T, show = T, check = F, next = F
        if delegate!.nextBtnPressed {
            showBtn.changeState()       //Enabled
            nextBtn.changeState()       //Disabled
            //checkBtn keep disabled
        }
        
    }
}
