//
//  CustomSignUpViewController.swift
//  CustomLogin
//
//  Created by Alexandra Lazea on 25/02/16.
//  Copyright © 2016 Medeea. All rights reserved.
//

import UIKit
import Parse

class CustomSignUpViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var usernameField: UITextField!

    @IBOutlet weak var passwordField: UITextField!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0,150,150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "SIGN UP"
        
        self.activityIndicator.center = self.view.center
        
        self.activityIndicator.hidesWhenStopped = true
        
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(self.activityIndicator)
        print("User before \(PFUser.currentUser())")
         self.navigationController?.navigationBarHidden = false
        
        
        usernameField.bounds = CGRect(x: 0, y: 0, width: view.bounds.width-50, height: 40)
        usernameField.center = CGPoint(x: view.bounds.width / 2, y: self.view.frame.size.height - 280)
        usernameField.placeholder = "Username"
        usernameField.font = UIFont.systemFontOfSize(15)
        usernameField.borderStyle = UITextBorderStyle.RoundedRect
        usernameField.autocorrectionType = UITextAutocorrectionType.No
        usernameField.keyboardType = UIKeyboardType.Default
        usernameField.returnKeyType = UIReturnKeyType.Done
        usernameField.clearButtonMode = UITextFieldViewMode.WhileEditing;
        usernameField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        usernameField.delegate = self
        self.view.addSubview(usernameField)
        
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

    //Actions
    
    @IBAction func signupAction(sender: AnyObject) {
        
        let username = self.usernameField.text
        let password = self.passwordField.text
        let email = self.emailField.text
        
        if (username!.utf16.count < 4 || password!.utf16.count < 5){
            
            let alert = UIAlertView(title: "Invalid", message: "Username must be greater then 4 and password must be greater then 5.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }
        else
            if (email!.utf16.count < 8){
                var alert = UIAlertView(title: "Invalid", message: "Please enter a valid email", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
            else{

                self.activityIndicator.startAnimating()
                let newUser = PFUser()
                newUser.username = username
                newUser.password = password
                newUser.email = email
                print("User 13: \(PFUser.currentUser())")

                newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                    self.activityIndicator.stopAnimating()
                    
                    if((error) != nil){
                        var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                        
                    }
                    else {
                        PFUser.logOut() //nu stiu de ce ramane logat
                        self.performSegueWithIdentifier("signuptologin", sender: self)
                        var alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                        
                    }
                    
                })
            }
        
    }
    
    
}
