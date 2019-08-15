//
//  MCView.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 10/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class MCView: UIView {
    
    @IBOutlet weak var MCQnScroll: UIScrollView!
    @IBOutlet weak var MCQuestion: MCQuestion!
    @IBOutlet weak var MCQnHeight: NSLayoutConstraint!
    @IBOutlet weak var MCStack: UIStackView!
    @IBOutlet var MCButtons: [ListButtonView]!
    @IBOutlet weak var utilityBar: UtilityBar!
    
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
    var isFirstQn = true
    
    //MARK: Utility Functions
    func displayMC(question: MultChoice) {
        MCQuestion.displayQuestion(question: question)
        if isFirstQn {
            //No animation
            displayChoice(question: question)
            isFirstQn = false
        }
        else {
            UIView.animate(withDuration: (MCAnimationDuration / 2), animations: {
                self.displayChoice(question: question)
                self.MCStack.layoutIfNeeded()
            })
        }
    }
    
    func displayChoice(question: MultChoice) {
        var choices = [question.CorrectAns, question.Distractor1, question.Distractor2]
        choices.shuffle()
        
        for num in 0...2 {
            MCButtons[num].listButton.type = type
            MCButtons[num].setUpButton(btnNum: num, title: choices[num], isMC: true)
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
            print("A")
            break
        case 1:
            print("B")
            break
        case 2:
            print("C")
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
                    button.toggleSelection(setOriginal: true)
                })
            }
        }
    }
    
    func toggleMCButtons() {
        for button in MCButtons {
            button.listButton.isEnabled = !button.listButton.isEnabled
        }
    }
    
    func scrollTo(bottom: Bool) {
        var offset: CGPoint = CGPoint(x: 0, y: 0)
        let offsetValue: CGFloat = MCQnScroll.contentSize.height - MCQnScroll.bounds.size.height

        if bottom && (offsetValue >= 0) {
            offset = CGPoint(x: 0, y: offsetValue)
        }
        MCQnScroll.setContentOffset(offset, animated: true)
    }
    
}
