//
//  BasicMCViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 15/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class BasicMCViewController: BasicViewController {
    
    @IBInspectable var mcPlistName: String? {
        didSet {
//            #if !TARGET_INTERFACE_BUILDER
//                loadPlistData()
//            #endif
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlistData()
    }
    
    var senderTag: Int? = nil
    var GSquestions = [[MultChoice]]()
    var MCquestions = [MultChoice]()
    
    func loadPlistData() {
        guard let plistName = self.mcPlistName else {
            print("Plist Name Not Found")
            return
        }
        guard let plist = PlistUtil.load(named: plistName) else {
            print("Failed To Load Plist \"\(plistName)\"")
            return
        }
        guard let questionsArray = plist.object(forKey: "MCQuestions") as? [NSArray] else {
            print("Failed To Load Plist As [[NSDictionary]]")
            return
        }
        
        guard senderTag != nil else {
            //Will only execute when senderTag == nil
            //i.e. View is loaded through GSTestMenu
            //Array index is the GS Test Question Type
            var i = 1
            for questionType in 0...(questionsArray.count - 1) {
                let questionsWithType = questionsArray[questionType] as! [NSDictionary]
                for questions in questionsWithType {
                    if let question = MultChoice(mcQn: questions) {
                        print("Loading type \(questionType) GSMC \(i)")
                        MCquestions.append(question)
                        i += 1
                    }
                }
                GSquestions.append(MCquestions)
                MCquestions.removeAll()
//                for j in 1...GSquestions[questionType].count {
//                    print(GSquestions[questionType][j - 1].Question)
//                    print(GSquestions[questionType][j - 1].CorrectAns)
//                    print(GSquestions[questionType][j - 1].Distractor1)
//                    print(GSquestions[questionType][j - 1].Distractor2)
//                    print(GSquestions[questionType][j - 1].Weighting)
//                }
            }
            return
        }
        
        //When senderTag != nil (senderTag will never be nil here
        //i.e. View is loaded through practice or test menu
        var i = 1
        let exCat = questionsArray[senderTag!] as! [NSDictionary]
        for questions in exCat {
            if let question = MultChoice(mcQn: questions) {
                print("Loading Practice/Test MC \(i)")
                MCquestions.append(question)
                i += 1
            }
        }
    }
}
