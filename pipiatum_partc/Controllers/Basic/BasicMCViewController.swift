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
    var currentType: ListBtnType = ListBtnType.none
    
    //For handling the display of MC questions and choices
    var currentQn: MultChoice? = nil
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
    
    func setUpMCView(utilBarName: String) {
        setUpComponent(componentName: utilBarName, superView: mcView!.utilityBar)
        mcView!.utilityBar.initUtilBar()
        
        switch currentType {
        case .gs:
            break
        case .practice, .test:
            //Need a different one for Test MC?
            //OR maybe all call setUpMC?
            setUpMC()
            break
        default:
            break
        }
    }
    
    func setUpGSMC() {
        //TBC
    }
    
    func setUpMC() {
        //temp
//        deleteData()
//        createData()
//        retrieveData()
//        updateData()
//        retrieveData()
        
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
            mcView!.showMC(question: currentQn!)
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
        mcView!.toggleMCButtons()
        if showFB {
            mcView!.scrollTo(bottom: true)
        }
        mcView!.MCQuestion.showFeedback(show: showFB)
    }
    
    func checkAns() {
        let correctBtn = getBtn(isCorrectBtn: true)
        let chosenBtn = getBtn(isCorrectBtn: false)
        
        if correctBtn == chosenBtn {
            marks += 1
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
        //Debug: MCAnimationDuration
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
        updateView()
        mcView!.toggleMCButtons()
        mcView!.scrollTo(bottom: false)
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
        
        let scoreEntity = NSEntityDescription.entity(forEntityName: entity, in: managedContext)!
        
        for i in 1...5 {
            let score = NSManagedObject(entity: scoreEntity, insertInto: managedContext)
            score.setValue(i, forKeyPath: timesAnswered)
            score.setValue((i + 10), forKeyPath: timesCorrAnswered)
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            for data in result as! [NSManagedObject] {
                print("timesAnswered: \(data.value(forKey: timesAnswered) as! Int32)")
            }
        } catch {
            print("Failed!")
        }
    }
    
    func updateData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: "\(timesAnswered) = %@", "1")
        do {
            let resultSet = try managedContext.fetch(fetchRequest)
            
            let record = resultSet[0] as! NSManagedObject
            
            let AnsValue = record.value(forKey: timesCorrAnswered) as? Int ?? 0
            
            record.setValue(100, forKey: timesAnswered)
            record.setValue(AnsValue + 1, forKey: timesCorrAnswered)
            
            do {
                try managedContext.save()
            }
            catch {
                print(error)
            }
            
        } catch {
            print(error)
        }
    }
    
    func deleteData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Delete all data in \(entity) error: \(error) \(error.userInfo)")
        }
    }
}
