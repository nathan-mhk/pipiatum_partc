//
//  MultChoice.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 17/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class MultChoice {
    //The text displayed before showing the question
    //Qns in GS DO NOT have prompts, marks and feedbacks
    var Prompt: String? = nil
    var Marks: Int? = nil
    var Feedback: String? = nil
    
    var Question: String = ""
    var CorrectAns: String = ""
    var Distractor1: String = ""
    var Distractor2: String = ""
    
    //-1 = Never answered before
    //[0, 9], Percentage of correctness, 9 = always correct
    var Weighting: Int = -1
    
    init?(mcQn: NSDictionary) {
        let question = mcQn.object(forKey: "Question") as? String
        let correctAns = mcQn.object(forKey: "CorrectAns") as? String
        let dis1 = mcQn.object(forKey: "Distractor1") as? String
        let dis2 = mcQn.object(forKey: "Distractor2") as? String
        let weighting = mcQn.object(forKey: "Weighting") as? Int
        
        let prompt = mcQn.object(forKey: "Prompt") as? String
        let marks = mcQn.object(forKey: "Marks") as? Int
        let feedback = mcQn.object(forKey: "Feedback") as? String

        if question != nil && correctAns != nil && dis1 != nil && dis2 != nil && weighting != nil {
            self.Question = question!
            self.CorrectAns = correctAns!
            self.Distractor1 = dis1!
            self.Distractor2 = dis2!
            self.Weighting = weighting!
        }
        else {
            //Question DNE
            return nil
        }
        if prompt != nil && marks != nil && feedback != nil {
            self.Prompt = prompt
            self.Marks = marks
            self.Feedback = feedback
            //Practice/Test question type
        }
        else  {
            self.Prompt = nil
            self.Marks = nil
            self.Feedback = nil
            //GS question type
        }
        
    }
}
