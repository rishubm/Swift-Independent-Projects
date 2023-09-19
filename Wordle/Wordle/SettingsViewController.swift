//
//  SettingsViewController.swift
//  Wordle
//
//  Created by Madhav, Rishub P on 3/22/23.
//

import UIKit

class SettingsViewController: UIViewController {

    var model : WordleModel? = nil
    var hardModeOn : Bool = false
    
    @IBOutlet var hardModeSwitch: UISwitch!
    
    override func viewWillAppear(_ animated: Bool) {
        hardModeSwitch.isOn = model!.hardModeOn
    }
    
    @IBAction func hardModeToggle(_ sender: UISwitch) {
        hardModeOn = sender.isOn
        model!.hardModeOn = self.hardModeOn
    }
    

}
