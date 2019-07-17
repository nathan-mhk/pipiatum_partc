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
    var questions = [MultChoice]()
    
    func loadPlistData() {
        guard let plistName = self.mcPlistName else {
            print("Plist Name Not Found")
            return
        }
        guard let plist = PlistUtil.load(named: plistName) else {
            print("Failed To Load Plist \"\(plistName)\"")
            return
        }
        
        guard let questionsArray = plist.object(forKey: "MCQuestions") as? [[NSDictionary]] else {
            print("Failed To Load Plist As [[NSDictionary]]")
            return
        }
        guard senderTag != nil else {
            //Will only execute when senderTag == nil
            //i.e. View is loaded through GSTestMenu
            for (questionType, dictionary) in questionsArray.enumerated() {
                for questions in dictionary {
                    if let question = MultChoice(mcQn: questions) {
                        GSquestions[questionType].append(question)
                    }
                }
            }
            return
            //ArrayIndex of GSquetionArray is the GS Question Type
        }
        
        
        print(senderTag!)
        
    }
}
