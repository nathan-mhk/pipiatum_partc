//
//  SettingsViewController.swift
//  pipiatum_partc
//
//  Created by Nathan Kong on 28/6/2019.
//  Copyright © 2019 Nathan Kong. All rights reserved.
//

import UIKit

class SettingsViewController: BasicViewController {
    
    @IBOutlet weak var stdFontBtn: ConfigButton!
    @IBOutlet weak var scriptFontBtn: ConfigButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setState(button: stdFontBtn)
        setState(button: scriptFontBtn)
    }
    
    //Called on click, won't call when button is disabled
    @IBAction func stdFontBtn(_ sender: ConfigButton) {
        changeState(button: sender)
        if !scriptFontBtn.isEnabled {
            changeState(button: scriptFontBtn)
        }
    }
    
    @IBAction func scriptFontBtn(_ sender: ConfigButton) {
        changeState(button: sender)
        if !stdFontBtn.isEnabled {
            changeState(button: stdFontBtn)
        }
    }
    
    private func changeState(button: ConfigButton) {
        button.isEnabled = !button.isEnabled
        setAlpha(button: button)
        //Save the state of the button as an array of boolean
        UserDefaults.standard.set(button.isEnabled, forKey: button.getKey())
        UserDefaults.standard.synchronize()
    }
    
    private func setState(button: ConfigButton) {
        //Retrieve the saved button state
        button.isEnabled = UserDefaults.standard.bool(forKey: button.getKey())
        setAlpha(button: button)
    }
    
    private func setAlpha(button: ConfigButton) {
        let alpha: CGFloat = button.isEnabled ? 1.0 : 0.5
        
        UIView.animate(withDuration: 0.15, animations: {
            button.alpha = alpha
        })
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}
