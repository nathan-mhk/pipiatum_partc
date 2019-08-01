//
//  MCView.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 10/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class MCView: UIView {
    
    @IBOutlet weak var utilityBar: UtilityBar!
    @IBOutlet weak var MCQuestion: MCQuestion!
    @IBOutlet weak var MCStack: UIStackView!
    @IBOutlet var MCButtons: [ListButtonView]!
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        setUpComponent(componentName: "MCView", superView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpComponent(componentName: "MCView", superView: self)
    }
   
    weak var delegate: MCDelegate?
    var type: ListBtnType = ListBtnType.none
    var isFirstTime = true
    
    //MARK: Utility Functions
    func showMC(question: MultChoice) {
        MCQuestion.showQuestion(question: question)
        if isFirstTime {
            showChoice(question: question)
            isFirstTime = false
        }
        else {
            UIView.animate(withDuration: (MCAnimationDuration / 2), animations: {
                self.showChoice(question: question)
                self.MCStack.layoutIfNeeded()
            })
        }
    }
    
    func showChoice(question: MultChoice) {
        var choices = [String]()
        choices.append(question.CorrectAns)
        choices.append(question.Distractor1)
        choices.append(question.Distractor2)
        choices.shuffle()
        
        for num in 0...2 {
            MCButtons[num].listButton.type = type
            MCButtons[num].setUpButton(btnNum: num, title: choices[num])
            MCButtons[num].delegate = delegate
            if choices[num] == question.CorrectAns {
                MCButtons[num].listButton.tag = -1
                ans(num: num)
            }
            else {
                MCButtons[num].listButton.tag = -2
            }
        }
    }
    
    func ans(num: Int) {
        switch num {
        case 0:
            print("A\n")
            break
        case 1:
            print("B\n")
            break
        case 2:
            print("C\n")
            break
        default:
            break
        }
    }
    
    //Will RESET EVERY MCBUTTON when called outside [ListButtonView.swift]: @IBAction func MCButton
    func updateView() {
        for button in MCButtons {
            if !button.listButton.isPressed {
                button.listButton.chosen = false
                
                UIView.animate(withDuration: MCAnimationDuration, animations: {
                    button.listButton.backgroundColor = button.listButton.originalColor
                    button.listButton.setTitleColor(.white, for: .normal)
                })
            }
        }
    }
    
    func toggleMCButtons() {
        for button in MCButtons {
            button.listButton.isEnabled = !button.listButton.isEnabled
        }
    }
    
}
