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
    
    //Saving
    var timesAnswered: Int = 0
    var timesCorrAnswered: Int = 0
    var accuracy: Float = 0.0
    
    //For GS
    var QnType: Int? = nil
    
    //For Practice/Test
    var Prompt: String? = nil       //The text displayed before showing the question
    var Marks: Int? = nil
    var Feedback: String? = nil
    var ExCat: String? = nil
    
    //MARK: Init from plist
    init?(mcQn: NSDictionary) {
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
            let feedback = mcQn.object(forKey: "Feedback") as? String {
            
            //For Practice/Test
            self.Prompt = prompt
            self.Marks = marks
            self.Feedback = feedback
            self.ExCat = exCat
            //print("Practice/Test questions")
        }
        else  {
            let qnType = mcQn.object(forKey: "QnCat") as? Int
            self.Prompt = nil
            self.Marks = nil
            self.Feedback = nil
            self.QnType = qnType
            //print("GS questions")
        }
    }
    
    //MARK: Init from saved data
   
}
