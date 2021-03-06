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
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0,y: 0,width: 150,height: 150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "SIGN UP"
        
        self.activityIndicator.center = self.view.center
        
        self.activityIndicator.hidesWhenStopped = true
        
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        view.addSubview(self.activityIndicator)
        print("User before \(PFUser.current())")
         self.navigationController?.isNavigationBarHidden = false
        
        
        usernameField.bounds = CGRect(x: 0, y: 0, width: view.bounds.width-50, height: 40)
        usernameField.center = CGPoint(x: view.bounds.width / 2, y: self.view.frame.size.height - 280)
        usernameField.placeholder = "Username"
        usernameField.font = UIFont.systemFont(ofSize: 15)
        usernameField.borderStyle = UITextBorderStyle.roundedRect
        usernameField.autocorrectionType = UITextAutocorrectionType.no
        usernameField.keyboardType = UIKeyboardType.default
        usernameField.returnKeyType = UIReturnKeyType.done
        usernameField.clearButtonMode = UITextFieldViewMode.whileEditing;
        usernameField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        //usernameField.delegate = self
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
    
    @IBAction func signupAction(_ sender: AnyObject) {
        
        let username = self.usernameField.text
        let password = self.passwordField.text
        let email = self.emailField.text
        
        if (username!.utf16.count < 4 || password!.utf16.count < 5){
            
            let alert = UIAlertView(title: "Invalid", message: "Username must be greater then 4 and password must be greater then 5.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }
        else
            if (email!.utf16.count < 8){
                let alert = UIAlertView(title: "Invalid", message: "Please enter a valid email", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
            else{

                self.activityIndicator.startAnimating()
                let newUser = PFUser()
                newUser.username = username
                newUser.password = password
                newUser.email = email
                print("User 13: \(PFUser.current())")

                newUser.signUpInBackground(block: { (succeed, error) -> Void in
                    self.activityIndicator.stopAnimating()
                    
                    if((error) != nil){
                        let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                        
                    }
                    else {
                        PFUser.logOut() //nu stiu de ce ramane logat
                        self.performSegue(withIdentifier: "signuptologin", sender: self)
                        let alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                        
                    }
                    
                })
            }
        
    }
    
    
}
