//
//  MultChoice.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 17/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class MultChoice {
    //For both qn type
    var QnNum: Int = 0
    var Question: String = ""
    var CorrectAns: String = ""
    var Distractor1: String = ""
    var Distractor2: String = ""
    //-1 = Never answered before
    //[0, 9], Percentage of correctness, 9 = always correct
    var Weighting: Int = -1
    
    //For GS
    var QnType: Int? = nil
    
    //For Practice/Test
    var Prompt: String? = nil       //The text displayed before showing the question
    var Marks: Int? = nil
    var Feedback: String? = nil
    var ExCat: String? = nil
    
    init?(mcQn: NSDictionary) {
        //TODO: Fix this
        /*
        if let qnNum = mcQn.object(forKey: "QnNum") as? Int,
            let question = mcQn.object(forKey: "Question") as? String,
            let correctAns = mcQn.object(forKey: "CorrectAns") as? String,
            let dis1 = mcQn.object(forKey: "Distractor1") as? String,
            let dis2 = mcQn.object(forKey: "Distractor2") as? String {
            
            self.QnNum = qnNum
            self.Question = question
            self.CorrectAns = correctAns
            self.Distractor1 = dis1
            self.Distractor2 = dis2
        }
        else {
            print("Question DNE")
            return nil
        }
        if let exCat = mcQn.object(forKey: "QnCat") as? String,
            let prompt = mcQn.object(forKey: "Prompt") as? String,
            let marks = mcQn.object(forKey: "Marks") as? Int,
            let feedback = mcQn.object(forKey: "Feedback") as? String,
            let qnType = mcQn.object(forKey: "QnCat") as? Int {
            
            //For Practice/Test
            self.Prompt = prompt
            self.Marks = marks
            self.Feedback = feedback
            self.ExCat = exCat
            //print("Practice/Test questions")
        }
        else  {
            self.Prompt = nil
            self.Marks = nil
            self.Feedback = nil
            self.QnType = qnType
            //print("GS questions")
        }
 */
        
        
        //For both qn type
        let qnNum = mcQn.object(forKey: "QnNum") as? Int
        let question = mcQn.object(forKey: "Question") as? String
        let correctAns = mcQn.object(forKey: "CorrectAns") as? String
        let dis1 = mcQn.object(forKey: "Distractor1") as? String
        let dis2 = mcQn.object(forKey: "Distractor2") as? String
        
        //For GS
        let qnType = mcQn.object(forKey: "QnCat") as? Int
        
        //For Practice/Test
        let exCat = mcQn.object(forKey: "QnCat") as? String
        let prompt = mcQn.object(forKey: "Prompt") as? String
        let marks = mcQn.object(forKey: "Marks") as? Int
        let feedback = mcQn.object(forKey: "Feedback") as? String

        if question != nil && correctAns != nil && dis1 != nil && dis2 != nil {
            //For both qn type
            self.QnNum = qnNum!
            self.Question = question!
            self.CorrectAns = correctAns!
            self.Distractor1 = dis1!
            self.Distractor2 = dis2!
            self.Weighting = -1
        }
        else {
            print("Question DNE")
            return nil
        }
        if prompt != nil && marks != nil && feedback != nil && exCat != nil{
            //For Practice/Test
            self.Prompt = prompt
            self.Marks = marks
            self.Feedback = feedback
            self.ExCat = exCat
            //print("Practice/Test questions")
        }
        else  {
            self.Prompt = nil
            self.Marks = nil
            self.Feedback = nil
            self.QnType = qnType
            //print("GS questions")
        }
        
    }
}
