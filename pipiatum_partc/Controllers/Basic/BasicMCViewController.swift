//
//  BasicMCViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 15/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class BasicMCViewController: BasicViewController, MCDelegate {
    
    @IBInspectable var mcPlistName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        GSquestions.removeAll()
        MCquestions.removeAll()
        loadPlistData()
    }
    
    //MARK: Load Plist Data
    var senderTag: Int? = nil
    var GSquestions = [[MultChoice]]()
    var MCquestions = [MultChoice]()
    
    func loadPlistData() {
        guard let plistName = self.mcPlistName else {
            print("Plist Name Not Found")
            return
        }
        guard let plist = PlistUtil.load(named: plistName) else {
            return
        }
        guard let questionsArray = plist.object(forKey: "MCQuestions") as? [NSArray] else {
            print("Failed To Load Plist As [NSArray]")
            return
        }
        
        guard senderTag != nil else {
            //Will only execute when senderTag == nil
            //i.e. View is loaded through GSTestMenu
            for questionType in 0...(questionsArray.count - 1) {
                let questionsWithType = questionsArray[questionType] as! [NSDictionary]
                for questions in questionsWithType {
                    if let question = MultChoice(mcQn: questions) {
                        MCquestions.append(question)
                    }
                }
                GSquestions.append(MCquestions)
                MCquestions.removeAll()
            }
            print("Loaded GS MC")
            return
        }
        
        //When senderTag != nil (senderTag will never be nil here
        //i.e. View is loaded through practice or test menu
        let exCat = questionsArray[senderTag!] as! [NSDictionary]
        for questions in exCat {
            if let question = MultChoice(mcQn: questions) {
                MCquestions.append(question)
            }
        }
        //Debug Msg
        print("Loaded Practice/Test MC")
    }
    
    //MARK: MC Handling
    var mcView: MCView? = nil
    var mcType: String = ""
    
    //For handling the display of MC questions and choices
    var currentQn: MultChoice? = nil
    var questionPool = [MultChoice]()
    
    //For handling the display of marks, total#Qns, #answeredQns, etc
    var totalQnAnswered: Int = 1
    var totalNumOfQns: Int = 0
    var marks: Int = 0
    
    //For handling different button events
    var firstMCSelected: Bool = false
    var mcBtnPressed: Bool = false
    var showBtnPressed: Bool = false
    var checkBtnPressed: Bool = false
    var nextBtnPressed: Bool = false
    var isEnd: Bool = false
    
    func setUpMCView(view: MCView, name: String, type: String) {
        mcView = view
        mcType = type
        
        setUpComponent(componentName: name, superView: view.utilityBar)
        view.utilityBar.initUtilBar(type: type)
        
        if mcType == "GS" {
            setUpGSMC()
        }
        else {
            //Need a different one for Test MC?
            //OR maybe all call setUpMC?
            //mcType == "Practice" || "Test"
            setUpMC()
        }
    }
    
    func setUpGSMC() {
        //TBC
    }
    
    func setUpMC() {
        questionPool.removeAll()
        for mark in 1...3 {
            //TODO: Grab the first 10 questions in load() only
            //Right now the database don't have enough questions
            questionPool += load(withMark: mark)
        }
        totalNumOfQns = questionPool.count
        showMC()
    }
    
    func load(withMark: Int) -> [MultChoice] {
        var tempArray = [MultChoice]()
        for question in MCquestions {
            if question.Marks == withMark {
                tempArray.append(question)
            }
        }
        return tempArray.shuffled()
    }
    
    func showMC() {
        self.title = "\(totalQnAnswered) of \(totalNumOfQns)"
        
        currentQn = questionPool.first
        if currentQn != nil && mcView != nil{
            print("Qn \(currentQn!.QnNum)")
            mcView!.showMC(question: currentQn!, type: mcType)
        }
        else {
            print("Error: currentQn/mcView is nil")
        }
    }
    
    func updateView() {
        if mcBtnPressed {
            mcView!.updateView()
        }
        mcView!.utilityBar.updateView()
    }
    
    func showAns(showFB: Bool) {
        let correctBtn = getBtn(isCorrectBtn: true)
        UIView.animate(withDuration: 0.3, animations: {
            correctBtn.listButton.backgroundColor = UIColor(hexString: "8BC45D")    //Green
        })
        mcView!.toggleMCButtons()
        mcView!.MCQuestion.showFeedback(show: showFB)
    }
    
    func checkAns() {
        let correctBtn = getBtn(isCorrectBtn: true)
        let chosenBtn = getBtn(isCorrectBtn: false)
        
        if correctBtn == chosenBtn {
            marks += 1
            mcView!.MCQuestion.updateMarks(marks: marks)
            
            switch mcType {
            case "GS":
                break
            case "Practice":
                showAns(showFB: true)
                break
            default:
                //Test
                showAns(showFB: false)
                doNextMC(btn: chosenBtn)
                break
            }
        }
        else {
            chosenBtn.setRightImg(show: true)
            
            switch mcType {
            case "GS":
                //TBC
                break
            case "Practice":
                showAns(showFB: true)   //Always show feedback
                break
            default:
                //Test
                //**Only show feedback when the ANS is wrong
                //After calling showAns, wait for a while then call nextMC
                UIView.animate(withDuration: 0.3, animations: {
                    chosenBtn.listButton.backgroundColor = UIColor(hexString: "FFFD72")   //Yellow
                })
                showAns(showFB: true)
                doNextMC(btn: chosenBtn)
                break
            }
        }
    }
    
    func getBtn(isCorrectBtn: Bool) -> ListButtonView {
        var correctBtn = ListButtonView()
        var chosenBtn = ListButtonView()
        for button in mcView!.MCButtons {
            if button.listButton.tag == -1 {
                correctBtn = button
            }
            if button.listButton.chosen {
                chosenBtn = button
            }
        }
        if isCorrectBtn {
            return correctBtn
        }
        return chosenBtn
    }
    
    func doNextMC(btn: ListButtonView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        //DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            if !self.isEnd {
                self.nextMC()
            }
            else {
                self.endMC(sender: btn.listButton)
            }
        }
    }
    
    func nextMC() {
        //Reset all subviews
        updateView()
        mcView!.toggleMCButtons()
        for button in mcView!.MCButtons {
            button.listButton.chosen = false
        }
        
        //Reset the variables
        firstMCSelected = false
        mcBtnPressed = false
        showBtnPressed = false
        checkBtnPressed = false
        nextBtnPressed = false
        
        totalQnAnswered += 1
        if !questionPool.isEmpty {
            questionPool.removeFirst()
            currentQn = nil
            showMC()
            if questionPool.count == 1 {
                isEnd = true
            }
        }
    }
    
    func endMC(sender: BasicButtonComponent) {
        var segueID = ""
        switch mcType {
        case "GS":
            segueID = "GS_RESULT"
            break
        case "Practice":
            segueID = "PRACTICE_RESULT"
            break
        default:
            //Test
            segueID = "TEST_RESULT"
            break
        }
        performSegue(withIdentifier: segueID, sender: sender)
    }
    
    func congratMsg() -> String {
        let percent = Float(marks) / Float(totalNumOfQns)
        switch percent {
        case 0.0..<0.2:
            return "Eheu!"              // 0, 1
        case 0.2..<0.5:
            return "Bene!"              // 2, 3, 4
        case 0.5..<0.9:
            return "Bene factum!"       // 5, 6, 7, 8
        case 0.9..<1.0:
            return "Optime factum!"     // 9
        default:
            return "Feliciter!"         //Full Mark
        }
    }
}
