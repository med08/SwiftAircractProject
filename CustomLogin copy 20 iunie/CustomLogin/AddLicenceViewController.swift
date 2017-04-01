//
//  AddLicenceViewController.swift
//  CustomLogin
//
//  Created by Alexandra Lazea on 02/03/16.
//  Copyright © 2016 Medeea. All rights reserved.
//

import UIKit
import Parse

class AddLicenceViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var licenceTypeField: UITextField!
    @IBOutlet weak var dateObtainedField: UITextField!
    @IBOutlet weak var expirationDateField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.navigationItem.title = "ADD LICENCE"
        
        dateObtainedField.delegate = self
        expirationDateField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addLicenceToDatabase(sender: UIButton) {
        let licenceType = self.licenceTypeField.text
        let dateObtained = self.dateObtainedField.text
        let expirationDate = self.expirationDateField.text
        let licence = PFObject(className: "Licence")
        
        licence["Type"] = licenceType
        licence["Date_obtained"] = dateObtained
        licence["Expiration_date"] = expirationDate
        licence["User"] = PFUser.currentUser()
        licence.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                let alert = UIAlertView(title: "Success", message: "\(licenceType!) licence successfully added.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                self.performSegueWithIdentifier("addLicenceToMainPage", sender: self)
            }
            else{
                let alert = UIAlertView(title: "Invalid", message: "\(licenceType!) licence could not be added.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    let datePicker = UIDatePicker()
    let datePicker2 = UIDatePicker()
    //create datepicker, textfield(is the 'lastInspection' field)
    func textFieldDidBeginEditing(textField: UITextField) {
        
        datePicker.datePickerMode = UIDatePickerMode.Date
        dateObtainedField.inputView = datePicker
        datePicker.addTarget(self, action: "datePickerChanged:", forControlEvents: .ValueChanged)

        datePicker2.datePickerMode = UIDatePickerMode.Date
        expirationDateField.inputView = datePicker2
        datePicker2.addTarget(self, action: "datePickerChanged:", forControlEvents: .ValueChanged)

        
    }
    
    func datePickerChanged(sender: UIDatePicker) {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        if sender == datePicker{
            dateObtainedField.text = formatter.stringFromDate(sender.date)
        }
        if sender == datePicker2{
            expirationDateField.text = formatter.stringFromDate(sender.date)
        }

    }
    
}