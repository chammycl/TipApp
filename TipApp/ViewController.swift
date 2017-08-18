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
    @IBOutlet weak var numPerson: UILabel!
    @IBOutlet weak var sharePerson: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var splitView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get theme
        loadTheme()
    
        //format bill field
        let billPlaceholder = Locale.current.currencySymbol
        billField!.placeholder = billPlaceholder
    
        //format tip, total, and share per person text labels
        let numFormat = NumberFormatter()
        numFormat.numberStyle = .currency
        numFormat.locale = Locale.current
        tipLabel.text = numFormat.string(from: 0)
        totalLabel.text = numFormat.string(from: 0)
        sharePerson.text = numFormat.string(from: 0)
        
        //set bill field as default
        billField.becomeFirstResponder()
    
        //load default tip percentage
        tipControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "SegmentTip")

        //get current Bill amount if app was used within 10min
        getCurrentBill()
        
        //calculate tip
        calcTip()
        
        //split bill
        splitBill()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        //get theme
        loadTheme()
        
        //load default tip percentage
        tipControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "SegmentTip")
        
        //calculate tip
        calcTip()
        
        //split bill
        splitBill()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func changePercent(_ sender: Any) {
        //bounch the total value upon change of tip percentage
        self.totalLabel.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
        
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6.0, options: [], animations: {
            self.totalLabel.transform = .identity
        }, completion: nil)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        //calculate tip
        calcTip()
    }
    
    @IBAction func stepper(_ sender: UIStepper) {
        //split bill
        splitBill()
    }

    @IBAction func sharePressed(_ sender: Any) {
        let message = "Total Bill: " + totalLabel.text! +
                      " Split Bill in: " + numPerson.text! +
                      " Share per Person: " + sharePerson.text!
        
        let activity = UIActivityViewController(activityItems: [message], applicationActivities: nil)
    
        activity.popoverPresentationController?.sourceView = self.view
        
        self.present(activity, animated: true, completion: nil)
    }
    
    //calculate tip
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
        
        //split bill
        splitBill()
    }
    
    //split bill
    func splitBill() {
        //set format of fields
        let numFormat = NumberFormatter()
        numFormat.numberStyle = .currency
        numFormat.locale = Locale.current
        let numTotal = numFormat.number(from: totalLabel.text!) ?? 0
        
        //number of persons to share the bill
        numPerson.text = String(Int(stepper.value))
        
        //share per person [of the bill]
        let total = numTotal.doubleValue
        let numPer = stepper.value
        
        //update share per person label
        if (numPer == 0.0) {
            sharePerson.text = numFormat.string(from: NSNumber(value: 0.0))
        } else {
            let share = total / numPer
            sharePerson.text = numFormat.string(from: NSNumber(value: share))
        }
    }
    
    //load theme
    func loadTheme() {
        //set initial alpha value
        self.tipappView.alpha = 0.2
        
        //animate view
        UIView.animate(withDuration: 1.0, delay: 0.2, options: [], animations: {
            self.tipappView.alpha = 1.0
        }, completion: nil)
        
        if (UserDefaults.standard.bool(forKey: "ThemeSwitch") == true) {
            //dark blue theme
            view.backgroundColor = UIColor(red: 0.1, green: 0.3, blue: 0.7, alpha: 1.0)
            tipControl.tintColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            splitView.backgroundColor = UIColor(red: 0.0, green: 0.7, blue: 1.0, alpha: 1.0)
            stepper.tintColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        } else {
            //default white theme
            view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            tipControl.tintColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
            splitView.backgroundColor = UIColor(red: 0.0, green: 0.35, blue: 1.0, alpha: 1.0)
            stepper.tintColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        //set splitView to rounded corners
        splitView.layer.cornerRadius = 10
    }
    
    //get previous bill value if app was currently used within 10min
    func getCurrentBill() {
        //retrieve date
        
        if (UserDefaults.standard.object(forKey: "TipAppDate") as? Date != nil) {
            let savedDate = UserDefaults.standard.object(forKey: "TipAppDate") as! Date
            let interval = Date().timeIntervalSince(savedDate)
        
            if (interval < 600) {
                //get current value for bill field (should be blank after 10min)
                billField.text = UserDefaults.standard.string(forKey: "Bill")
            } else {
                billField.text = ""
            }
        } else {
            billField.text = ""
        }
    }
}

