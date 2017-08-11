//
//  ViewController.swift
//  TipApp
//
//  Created by Charm Chammag on 8/8/17.
//  Copyright © 2017 Charm Chammag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet var tipappView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get theme
        loadTheme()
    
        //format bill field
        let billPlaceholder = Locale.current.currencySymbol
        billField!.placeholder = billPlaceholder
    
        //format tip and total text labels
        let numFormat = NumberFormatter()
        numFormat.numberStyle = .currency
        numFormat.locale = Locale.current
        tipLabel.text = numFormat.string(from: 0)
        totalLabel.text = numFormat.string(from: 0)
        
        //set bill field as default
        billField.becomeFirstResponder()
    
        //load default tip percentage
        tipControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "SegmentTip")
    
        //get current value for bill field (should be blank after 10min)
        billField.text = UserDefaults.standard.string(forKey: "Bill")
        
        calcTip()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        //set initial alpha value
        self.tipappView.alpha = 0.2
        
        //get theme
        loadTheme()
        
        //load default tip percentage
        tipControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "SegmentTip")
        
        //get current value for bill field (should be blank after 10min)
        billField.text = UserDefaults.standard.string(forKey: "Bill")
        
        calcTip()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //animate view
        UIView.animate(withDuration: 1.0, delay: 0.3,
                                   options: [],
                                   animations: {
                                    self.tipappView.alpha = 1.0
        }, completion: nil)
        
        //get theme
        loadTheme()

        //load default tip percentage
        tipControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "SegmentTip")
        
        //get current value for bill field (should be blank after 10min)
        billField.text = UserDefaults.standard.string(forKey: "Bill")
        
        calcTip()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        //calculate tip
        calcTip()
    }
    
    //calculate theme
    func calcTip() {
        let tipPercentages = [0.1, 0.15, 0.2, 0.25, 0.3]
    
        //set format of fields
        let numFormat = NumberFormatter()
        numFormat.numberStyle = .currency
        numFormat.locale = Locale.current
        
        //compute tip
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
    
        //update labels
        tipLabel.text = numFormat.string(from: NSNumber(value: tip))
        totalLabel.text = numFormat.string(from: NSNumber(value: total))
        
        //save bill value in UserDefaults
        UserDefaults.standard.set(billField.text, forKey: "Bill")
    }
    
    //load theme
    func loadTheme() {
        if (UserDefaults.standard.bool(forKey: "ThemeSwitch") == true) {
            //dark blue theme
            view.backgroundColor = UIColor(red: 0.1, green: 0.3, blue: 0.7, alpha: 1.0)
            tipControl.tintColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        } else {
            //default white theme
            view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            tipControl.tintColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        }
    }
    
}

