//
//  AddAirplaneViewController.swift
//  CustomLogin
//
//  Created by Alexandra Lazea on 28/02/16.
//  Copyright © 2016 Medeea. All rights reserved.
//

import UIKit
import Parse

class AddAirplaneViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var registrationField: UITextField!
    @IBOutlet weak var speedField: UITextField!
    @IBOutlet weak var hoursField: UITextField!
    @IBOutlet weak var inspectionField: UITextField!
    @IBOutlet weak var inspIntervalField: UITextField!
    var fromUserDetails = 0
    var fromAddSelectAirplane = 0
    var Values = ["50 hours","100 hours","150 hours"]
    var answer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.navigationItem.title = "ADD AIRPLANE"
        
        // Do any additional setup after loading the view.
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        inspectionField.delegate = self
        print("User details: \(fromUserDetails)")
        print("Add Select Airplane: \(fromAddSelectAirplane)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
    @IBAction func addAircraft(_ sender: AnyObject) {
    
        
        let registration = self.registrationField.text
        let type = self.typeField.text
        let speed = self.speedField.text
        let hours = self.hoursField.text
        let inspection = self.inspectionField.text
        
        let plane = PFObject(className: "Aircrafts")
        plane["Type"] = type
        plane["Registration"] = registration
        plane["StallSpeed"] = speed
        plane["FlightHours"] = hours
        plane["LastInspection"] = inspection
        plane["InspInterval"] = Values[answer]
        plane["User"] = PFUser.current()
        plane["CurrentAirplane"] = 1
        
        beforeAdd(sender)
        plane.saveInBackground { (success, error) -> Void in
            if success {
                let alert = UIAlertView(title: "Success", message: "\(type!) successfully added.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                if self.fromUserDetails == 1{
                    self.performSegue(withIdentifier: "addAirplaneToMainPage", sender: self)
                }
                else{
                    self.performSegue(withIdentifier: "addToAddSelect", sender: self)
                }
            }
            else{
                let alert = UIAlertView(title: "Success", message: "Aircraft could not be added.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
        }
    }
    
    func beforeAdd(_ sender: AnyObject){
        
        let query = PFQuery(className: "Aircrafts")
        let currentUser = PFUser.current()
        query.whereKey("User", equalTo: currentUser!)
        //query.whereKey("Type", equalTo: "CPL") imi intoarce doar anumite linii
        //query.selectKeys("Type") doar coloana asta
        //query.orderByAscending("Type")
        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil{
                //there was no error in the fetch
                if let returnedobjects = objects {
                    for object in returnedobjects{
                       object["CurrentAirplane"] = 0
                       object.saveInBackground()
                    }
                }
            }
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Values[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Values.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        answer = row
    }
    
    //create datepicker, textfield(is the 'lastInspection' field)
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(AddAirplaneViewController.datePickerChanged(_:)), for: .valueChanged)
    }
    
    func datePickerChanged(_ sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        inspectionField.text = formatter.string(from: sender.date)
    }
    
    //Inspection text field(begin editing)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true 
    }
    
    //Close keybord when when touch the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
