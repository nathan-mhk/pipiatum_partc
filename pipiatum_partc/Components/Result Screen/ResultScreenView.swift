//
//  ResultScreenView.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 10/7/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class ResultScreenView: UIView {

    @IBOutlet weak var congrats: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var whiteScore: UILabel!
    @IBOutlet weak var qnType: UILabel!
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        setUpComponent(componentName: "ResultScreenView", superView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpComponent(componentName: "ResultScreenView", superView: self)
    }
    
    func setUpResult(msg: String, marks: Int, total: Int, type: String) {
        congrats.text = msg
        if marks != 10 {
            score.text = " \(marks)/\(total)"
        }
        else {
            score.text = "\(marks)/\(total)"
        }
        whiteScore.text = score.text
        qnType.text = "in this " + type
    }
}
