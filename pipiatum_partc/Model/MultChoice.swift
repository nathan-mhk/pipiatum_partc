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
    var QnCat: String = ""
    var QnNum: Int = 0
    var Question: String = ""
    var CorrectAns: String = ""
    var Distractor1: String = ""
    var Distractor2: String = ""
    
    //Saving
    var totalTimes: Int = 0
    var corrTimes: Int = 0
    var accuracy: Float = 0.0
    
    var weighting: Int = 0
    
    //For Practice/Test
    var Prompt: String = ""
    var Marks: Int = 0
    var Feedback: String = ""
    
    //MARK: Init from plist
    init?(mcQn: NSDictionary) {
        if let qnCat = mcQn.object(forKey: "QnCat") as? String,
            let qnNum = mcQn.object(forKey: "QnNum") as? Int,
            let question = mcQn.object(forKey: "Question") as? String,
            let correctAns = mcQn.object(forKey: "CorrectAns") as? String,
            let dis1 = mcQn.object(forKey: "Distractor1") as? String,
            let dis2 = mcQn.object(forKey: "Distractor2") as? String {
            
            self.QnCat = qnCat
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
        if let prompt = mcQn.object(forKey: "Prompt") as? String,
            let marks = mcQn.object(forKey: "Marks") as? Int,
            let feedback = mcQn.object(forKey: "Feedback") as? String {
            
            //For Practice/Test
            self.Prompt = prompt
            self.Marks = marks
            self.Feedback = feedback
        }
//        else  {
//            self.Prompt = ""
//            self.Marks = 0
//            self.Feedback = ""
//        }
    }
    
    func calculateAccuracy() {
        if totalTimes != 0 {
            accuracy = Float(corrTimes) / Float(totalTimes)
        }
    }
}
