//
//  SettingsViewController.swift
//  TipApp
//
//  Created by Charm Chammag on 8/8/17.
//  Copyright © 2017 Charm Chammag. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet var settingsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //get current settings for tipControl
        tipControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "SegmentTip")
        
        //get current settings for theme
        themeSwitch.isOn = UserDefaults.standard.bool(forKey: "ThemeSwitch")
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSegmentClick(_ sender: Any) {
        //save selected tipControl settings
        UserDefaults.standard.set(tipControl.selectedSegmentIndex, forKey: "SegmentTip")
    }

    @IBAction func changeTheme(_ sender: Any) {
        //save selected theme settings
        UserDefaults.standard.set(themeSwitch.isOn, forKey: "ThemeSwitch")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
}
