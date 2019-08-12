//
//  BasicMCViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 15/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit
import CoreData

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
    
    //Contains every question in GSMC.plist
    var GSquestions = [[MultChoice]]()
    
    //Contains every question of the given ExCat
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
            return
        }
        
        //When senderTag != nil
        //i.e. View is loaded through practice or test menu
        let exCat = questionsArray[senderTag!] as! [NSDictionary]
        for questions in exCat {
            if let question = MultChoice(mcQn: questions) {
                MCquestions.append(question)
            }
        }
    }
    
    //MARK: MC Handling
    var mcView: MCView? = nil
    var currentType: ListBtnType = ListBtnType.none
    
    //For handling the display of MC questions and choices
    var currentQn: MultChoice? = nil
    var currentQnNum: Int = 0   //Array index to read questionPool
    var questionPool = [MultChoice]()
    
    //For handling the display of marks, total#Qns, #answeredQns, etc
    var totalQnAnswered: Int = 1
    var totalNumOfQns: Int = 0
    var marks: Int = 0
    
    //For handling different button events by manipulating these button states
    var firstMCSelected: Bool = false
    var mcBtnPressed: Bool = false
    var showBtnPressed: Bool = false
    var checkBtnPressed: Bool = false
    var nextBtnPressed: Bool = false
    var isEnd: Bool = false
    
    //For CoreData
//    var appDelegate: AppDelegate? = nil
//    var managedContext: NSManagedObjectContext
    
    func setUpMCView(utilBarName: String) {
        setUpComponent(componentName: utilBarName, superView: mcView!.utilityBar)
        mcView!.utilityBar.initUtilBar()
        
        setUpMC()
    }
    
    func setUpMC() {
        questionPool.removeAll()
        var tempArray = [MultChoice]()
        switch currentType {
        case .gs:
            //TBC
            break
        case .practice:
            //Qn 1: 1pt
            setPracticeMC(mark: 1)
            
            //Qn 2-9: 2pts
            tempArray = getQuestions(withMark: 2).shuffled()
            tempArray = Array(tempArray[0..<8])                 //Right now the plist contains just enough (9) data
            questionPool.append(contentsOf: tempArray)
            
            //Qn 10: 3pts
            setPracticeMC(mark: 3)
            break
        case .test:
            //TODO
            //Qn 1: 1pt
            questionPool.append(prepareTestMC(mark: 1).first!)
            
            //Qn 2-9: 2pts
            //Right now the plist contains just enough (9) data
            questionPool.append(contentsOf: Array(prepareTestMC(mark: 2)[0..<8]).shuffled())
            
            //Qn 10: 3pts
            questionPool.append(prepareTestMC(mark: 3).first!)
            break
        default:
            break
        }
        //Load data
        accessData(isSave: false)
        totalNumOfQns = questionPool.count
        displayMC()
    }
    
    func setPracticeMC(mark: Int) {
        questionPool.append(getQuestions(withMark: mark).shuffled().first!)
    }
    
    func prepareTestMC(mark:Int) -> [MultChoice] {
        let tempArray = getQuestions(withMark: mark)
        
        //TODO
        //var tempArray = getQuestions(withMark: mark).sorted(by: {$0.accuracy < $1.accuracy})
        
        //Ditch this in future build
        return tempArray
        
        
        //Temporarily ditched due to insufficient data in TestMC.plist
        //Use the following code in future(beta) build:
        /*
        //TODO
        return Array(tempArray[0..<19]).shuffled()
         */
    }
    
    func getQuestions(withMark: Int) -> [MultChoice] {
        var tempArray = [MultChoice]()
        for question in MCquestions {
            if question.Marks == withMark {
                tempArray.append(question)
            }
        }
        //Contains an array of questions of the given marks
        return tempArray
    }
    
    func displayMC() {
        self.navigationItem.title = "\(totalQnAnswered) of \(totalNumOfQns)"
        
        currentQn = questionPool[currentQnNum]
        if currentQn != nil && mcView != nil{
            print("\n(\(currentQnNum + 1)) Qn \(currentQn!.QnNum + 1)")
            print("Accuracy: \(currentQn!.corrTimes)/\(currentQn!.totalTimes) (\(currentQn!.accuracy))")
            mcView!.displayMC(question: currentQn!)
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
        UIView.animate(withDuration: MCAnimationDuration, animations: {
            correctBtn.listButton.backgroundColor = UIColor(hexString: green)
        })
        //Disable all MCButtons
        mcView!.toggleMCButtons()
        //Update the states of UILabel Feedback
        mcView!.MCQuestion.toggleFeedback(show: showFB)
        //Scroll to bottom if showing FB
        mcView!.scrollTo(bottom: showFB)
    }
    
    func checkAns() {
        currentQn!.totalTimes += 1
        let correctBtn = getBtn(isCorrectBtn: true)
        let chosenBtn = getBtn(isCorrectBtn: false)
        
        if correctBtn == chosenBtn {
            marks += 1
            currentQn!.corrTimes += 1
            mcView!.MCQuestion.updateMarks(marks: marks)
            
            switch currentType {
            case .gs:
                break
            case .practice:
                showAns(showFB: true)
                break
            case .test:
                showAns(showFB: false)
                doNextMC(btn: chosenBtn)
                break
            default:
               break
            }
        }
        else {
            chosenBtn.setRightImg(show: true)
            switch currentType {
            case .gs:
                //TBC
                break
            case .practice:
                showAns(showFB: true)   //Always show feedback
                break
            case .test:
                //**Only show feedback when the ANS is wrong
                //After calling showAns, wait for a while then call nextMC
                UIView.animate(withDuration: MCAnimationDuration, animations: {
                    chosenBtn.listButton.backgroundColor = UIColor(hexString: yellow)
                })
                showAns(showFB: true)
                doNextMC(btn: chosenBtn)
                break
            default:
                break
            }
        }
        
        if currentType == .test {
            accessData(isSave: true)
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
/*******************************************************************************/
        //Debug: use MCAnimationDuration
        //DispatchQueue.main.asyncAfter(deadline: .now() + MCAnimationDuration) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(testMCDelay)) {
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
        //Reset the states of UtilBar
        updateView()
        //Re-enable all MCButtons
        mcView!.toggleMCButtons()
        //Scroll back to top
        mcView!.scrollTo(bottom: false)
        //Hide the feedback
        mcView!.MCQuestion.toggleFeedback(show: false)
        //Reset the chosen attributes of all MCButtons
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
        currentQnNum += 1   // <------------
        //currentQnNum == next question num|
        if currentQnNum == questionPool.count - 1 {
            isEnd = true
        }
        currentQn = nil
        
        //The duration here should be same as the duration of toggleFeedback(show: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + (MCAnimationDuration / 2)) {
            self.displayMC()
        }
    }
    
    func endMC(sender: BasicButtonComponent) {
        var segueID = ""
        switch currentType {
        case .gs:
            segueID = "GS_RESULT"
            break
        case .practice:
            segueID = "PRACTICE_RESULT"
            break
        case .test:
            segueID = "TEST_RESULT"
            break
        default:
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
    
    //MARK: CoreData
    
    func createData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        
        for question in questionPool {
            let performance = NSManagedObject(entity: entity, insertInto: managedContext)
            performance.setValue(question.QnCat, forKey: qnCategory)
            performance.setValue(question.QnNum, forKey: qnNumber)
            performance.setValue(0, forKeyPath: corrTimes)
            performance.setValue(0, forKeyPath: totalTimes)
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func accessData(isSave: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entityName)
        
        //WARNING: COULD FAILED(crash) IF questionPool.first!.QnCat DNE
        //Although supposedly questionPool.first!.QnCat should exist
        //Use the category to find the corresponding saved data of a question
        fetchRequest.predicate = NSPredicate(format: "\(qnCategory) = %@", questionPool.first!.QnCat)
        
        do {
            let resultSet = try managedContext.fetch(fetchRequest)
            
            //If there exist some data
            if resultSet.count != 0 {
                for record in resultSet as! [NSManagedObject] {
                    let num = record.value(forKey: qnNumber) as! Int
                    
                    if isSave {
                        //Update data
                        if num == currentQn!.QnNum {
                            record.setValue(currentQn!.totalTimes, forKey: totalTimes)
                            record.setValue(currentQn!.corrTimes, forKey: corrTimes)
                        }
                    } else {
                        //Retrieve data
                        //Attempts to match each of the retrieved data with questionPool[]
                        for question in questionPool {
                            if num == question.QnNum {
                                question.totalTimes = record.value(forKey: totalTimes) as! Int
                                question.corrTimes = record.value(forKey: corrTimes) as! Int
                                question.calculateAccuracy()
                                
                            }
                        }
                    }
                }
                
                if isSave {
                    do {
                        try managedContext.save()
                    } catch {
                        print("Failed to save: \(error)")
                    }
                }
                
            } else {
                createData()
            }
        } catch {
            print("Data access failed")
        }
    }
    
    //TODO, for Laterbase
    /*
    func deleteData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Failed to delete all data in \(entityName) error: \(error) \(error.userInfo)")
        }
    }*/
}
