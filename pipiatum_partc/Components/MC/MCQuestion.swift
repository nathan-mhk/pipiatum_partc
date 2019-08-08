//
//  MCQuestion.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 23/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class MCQuestion: UIView {
    
    //Always Exist
    @IBOutlet weak var Question: UILabel!
    @IBOutlet weak var Marks: UILabel!
    
    //Exist only in Practice and Test
    @IBOutlet weak var ExCat: UILabel!
    @IBOutlet weak var Prompt: UILabel!
    @IBOutlet weak var Feedback: UILabel!
    
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        setUpComponent(componentName: "MCQuestion", superView: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpComponent(componentName: "MCQuestion", superView: self)
    }
    
    var isFirstTime: Bool = true
    var fb: String = ""
    
    func showQuestion(question: MultChoice) {
        ExCat.fadeTransition(MCAnimationDuration)
        ExCat.text = question.QnCat
        
        Prompt.fadeTransition(MCAnimationDuration)
        Prompt.text = question.Prompt
        
        Question.fadeTransition(MCAnimationDuration)
        Question.text = question.Question
        
        //For Practice, always show feedback
        //For Test, only show feedback when ANS is wrong
        fb = question.Feedback!
        showFeedback(show: false)
    }
    
    func updateMarks(marks: Int) {
        Marks.fadeTransition(MCAnimationDuration)
        Marks.text = String(marks)
    }
    
    func showFeedback(show: Bool) {
        if isFirstTime {
            Feedback.alpha = 0.0
            Feedback.text = fb
            isFirstTime = false
        }
        else {
            let alpha: CGFloat = show ? 1.0 : 0.0
            let duration: TimeInterval = show ? MCAnimationDuration : (MCAnimationDuration / 2)
            UIView.animate(withDuration: duration, animations: {
                self.Feedback.alpha = alpha
            }, completion: {_ in
                self.Feedback.text = self.fb
            })
        }
    }
}
