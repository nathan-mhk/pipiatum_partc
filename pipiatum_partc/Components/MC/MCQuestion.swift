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
    
    var isFirstQn: Bool = true
    var htmlString: String = ""
    
    func displayQuestion(question: MultChoice) {
        ExCat.fadeTransition(MCAnimationDuration)
        ExCat.text = question.QnCat
        
        Prompt.fadeTransition(MCAnimationDuration)
        htmlString = gethtmlWhiteString(string: question.Prompt, isBold: false)
        Prompt.attributedText = convertToAttrString(string: htmlString)
        
        Question.fadeTransition(MCAnimationDuration)
        htmlString = gethtmlWhiteString(string: question.Question, isBold: false)
        Question.attributedText = convertToAttrString(string: htmlString)
        
        //Feedback
        //Set alpha = 0 with no animation when displaying the first question
        if isFirstQn {
            Feedback.alpha = 0.0
            isFirstQn = false
        }
        htmlString = gethtmlWhiteString(string: question.Feedback , isBold: false)
        Feedback.attributedText = convertToAttrString(string: htmlString)
        setFormatting(labels: [Prompt, Question, Feedback])
    }
    
    func setFormatting(labels: [UILabel]) {
        for label in labels {
            label.textAlignment = .center
            label.font = label.font.withSize(16)
            label.layoutIfNeeded()
        }
    }
    
    func updateMarks(marks: Int) {
        Marks.fadeTransition(MCAnimationDuration)
        Marks.text = String(marks)
    }
    
    func toggleFeedback(show: Bool) {
        let alpha: CGFloat = show ? 1.0 : 0.0
        let duration: TimeInterval = show ? MCAnimationDuration : (MCAnimationDuration / 2)
      
        UIView.animate(withDuration: duration, animations: {
            self.Feedback.alpha = alpha
        })
    }
}
