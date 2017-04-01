//
//  displayFlightsViewController.swift
//  CustomLogin
//
//  Created by Alexandra Lazea on 18/04/16.
//  Copyright © 2016 Medeea. All rights reserved.
//

import UIKit
import Parse

class displayFlightsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let dayField = UITextField(frame: CGRectMake(0, 260, 300, 40))
    let monthField = UITextField(frame: CGRectMake(0, 300, 300, 40))
    let yearField = UITextField(frame: CGRectMake(0, 350, 300, 40))
    let airplaneField = UITextField()

    let dayPickOption = ["Any day","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
    let monthPickOption = ["Any month","January","February","March","April","May","June","July","August","September","October","November","December"]
    let yearPickOption = ["Any year","2016","2017","2018","2019","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030"]
    var airplanePickOption: [String] = [String]()
    var searchParameters: [String] = ["","","",""]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "LOGBOOK"
        
        
        airplanePickOption.append("Any airplane")
        
        let currentUser = PFUser.currentUser()
        let query = PFQuery(className: "Flight")
        
        query.whereKey("user", equalTo: currentUser!)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil{
                //there was no error in the fetch
                if let returnedobjects = objects {
                    
                    for object in returnedobjects{
                        if !self.airplanePickOption.contains(object["registration"] as! String) {
                            self.airplanePickOption.append(object["registration"] as! String)
                        }
                        //self.airplanePickOption.append(object["registration"] as! String)
                    }
                }
            }
        }
        
        let label = UILabel()
        label.bounds = CGRect(x: 0, y: 0, width: view.bounds.width - 30, height: 80)
        label.center = CGPoint(x: view.bounds.width / 2, y: 100)
        label.backgroundColor = UIColor(patternImage: UIImage(named: "Icon-Spotlight-40")!)
        label.font = UIFont.systemFontOfSize(20)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        label.text = "Display flights for:"
        self.view.addSubview(label)

        
        dayField.bounds = CGRect(x: 0, y: 0, width: view.bounds.width-50, height: 40)
        dayField.center = CGPoint(x: view.bounds.width / 2, y: 200)
        dayField.placeholder = "Day"
        dayField.font = UIFont.systemFontOfSize(15)
        dayField.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(dayField)
        
        
        monthField.bounds = CGRect(x: 0, y: 0, width: view.bounds.width-50, height: 40)
        monthField.center = CGPoint(x: view.bounds.width / 2, y: 250)
        monthField.placeholder = "Month"
        monthField.font = UIFont.systemFontOfSize(15)
        monthField.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(monthField)
        
        
        yearField.bounds = CGRect(x: 0, y: 0, width: view.bounds.width-50, height: 40)
        yearField.center = CGPoint(x: view.bounds.width / 2, y: 300)
        yearField.placeholder = "Year"
        yearField.font = UIFont.systemFontOfSize(15)
        yearField.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(yearField)
        
        airplaneField.bounds = CGRect(x: 0, y: 0, width: view.bounds.width-50, height: 40)
        airplaneField.center = CGPoint(x: view.bounds.width / 2, y: 350)
        airplaneField.placeholder = "Airplane"
        airplaneField.font = UIFont.systemFontOfSize(15)
        airplaneField.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(airplaneField)
        
        let dayPickerView = UIPickerView()
        dayPickerView.delegate = self
        dayField.inputView = dayPickerView
        
        let monthPickerView = UIPickerView()
        monthPickerView.delegate = self
        monthField.inputView = monthPickerView
        
        let yearPickerView = UIPickerView()
        yearPickerView.delegate = self
        yearField.inputView = yearPickerView
        
        let airplanePickerView = UIPickerView()
        airplanePickerView.delegate = self
        airplaneField.inputView = airplanePickerView
        
        dayPickerView.tag = 0
        monthPickerView.tag = 1
        yearPickerView.tag = 2
        airplanePickerView.tag = 3

        let button1   = UIButton(type: UIButtonType.System) as UIButton
        button1.bounds = CGRect(x: 0, y: 0, width: view.bounds.width - 30, height: 80)
        button1.center = CGPoint(x: view.bounds.width / 2, y: self.view.frame.size.height - 180)
        
        button1.setBackgroundImage(UIImage(named: "Icon-Spotlight-40"), forState: UIControlState.Normal)
        button1.titleLabel?.font = UIFont.systemFontOfSize(20)
        button1.setTitleColor(UIColor.whiteColor(), forState:  UIControlState.Normal)
        
        
        button1.setTitle("Custom search", forState: UIControlState.Normal)
        button1.addTarget(self, action: #selector(displayFlightsViewController.button1Action(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button1)
        
        
         let button   = UIButton(type: UIButtonType.System) as UIButton
         button.bounds = CGRect(x: 0, y: 0, width: view.bounds.width - 30, height: 80)
         button.center = CGPoint(x: view.bounds.width / 2, y: self.view.frame.size.height - 90)
         button.setTitle("Show all flights", forState: UIControlState.Normal)
         
         button.setBackgroundImage(UIImage(named: "Icon-Spotlight-40"), forState: UIControlState.Normal)
         button.titleLabel?.font = UIFont.systemFontOfSize(20)
         button.setTitleColor(UIColor.whiteColor(), forState:  UIControlState.Normal)
         
         button.addTarget(self, action: #selector(displayFlightsViewController.buttonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
         self.view.addSubview(button)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func buttonAction(sender:UIButton!)
    {
        self.performSegueWithIdentifier("allFlights", sender: self)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        searchParameters[0] = self.dayField.text!
        //searchParameters[1] = self.monthField.text!
        searchParameters[2] = self.yearField.text!
        searchParameters[3] = self.airplaneField.text!
        if self.monthField.text! == "January"{
            searchParameters[1] = "01"}
        else if self.monthField.text! == "February"{
            searchParameters[1] = "02"}
        else if self.monthField.text! == "March"{
            searchParameters[1] = "03"}
        else if self.monthField.text! == "April"{
            searchParameters[1] = "04"}
        else if self.monthField.text! == "May"{
            searchParameters[1] = "05"}
        else if self.monthField.text! == "June"{
            searchParameters[1] = "06"}
        else if self.monthField.text! == "July"{
            searchParameters[1] = "07"}
        else if self.monthField.text! == "August"{
            searchParameters[1] = "08"}
        else if self.monthField.text! == "September"{
            searchParameters[1] = "09"}
        else if self.monthField.text! == "October"{
            searchParameters[1] = "10"}
        else if self.monthField.text! == "November"{
            searchParameters[1] = "11"}
        else if self.monthField.text! == "December"{
            searchParameters[1] = "12"}
        else{  searchParameters[1] = self.monthField.text! }
        
        
        if (segue.identifier == "customFlights") {
            let svc = segue.destinationViewController as! allFlightsViewController;
            svc.custom = 1
            svc.searchParameters = searchParameters
        }
    }
    
    func button1Action(sender:UIButton!)
    {
        if self.dayField.text! == ""{
            let alertController = UIAlertController(title: "Error", message:
                "You didn't select a day", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else if self.monthField.text! == ""{
            let alertController = UIAlertController(title: "Error", message:
                "You didn't select a month", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else if self.yearField.text! == ""{
            let alertController = UIAlertController(title: "Error", message:
                "You didn't select a year", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else if self.airplaneField.text! == ""{
            let alertController = UIAlertController(title: "Error", message:
                "You didn't select an airplane", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else{
            self.performSegueWithIdentifier("customFlights", sender: self)
        }
        
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            return dayPickOption.count
        }
        if pickerView.tag == 1{
            return monthPickOption.count
        }
        if pickerView.tag == 2{
            return yearPickOption.count
        }
        if pickerView.tag == 3{
            return airplanePickOption.count
        }
        return 1
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0{
            return dayPickOption[row]
        }
        if pickerView.tag == 1{
            return monthPickOption[row]
        }
        if pickerView.tag == 2{
            return yearPickOption[row]
        }
        if pickerView.tag == 3{
            return airplanePickOption[row]
        }
        return ""
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0{
            dayField.text = dayPickOption[row]
        }
        if pickerView.tag == 1{
            monthField.text = monthPickOption[row]
        }
        if pickerView.tag == 2{
            yearField.text = yearPickOption[row]
        }
        if pickerView.tag == 3{
            airplaneField.text = airplanePickOption[row]
        }
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
