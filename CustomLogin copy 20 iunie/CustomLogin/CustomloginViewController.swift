//
//  CustomloginViewController.swift
//  CustomLogin
//
//  Created by Alexandra Lazea on 25/02/16.
//  Copyright © 2016 Medeea. All rights reserved.
//

import UIKit
import Parse

class CustomloginViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {


    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0,150,150)) as UIActivityIndicatorView
    
    //let usernameField = UITextField(frame: CGRectMake(20, 100, 300, 40))
    let usernameField = UITextField(frame: CGRectMake(0, 360, 300, 40))
    let passwordField = UITextField(frame: CGRectMake(20, 150, 300, 40))
    let login_button = UIButton(type: UIButtonType.System)
    let signup_button = UIButton(type: UIButtonType.System)
    let start_button = UIButton(type: UIButtonType.System)
    let change_button = UIButton(type: UIButtonType.System)
    let signout_button = UIButton(type: UIButtonType.System)

    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.navigationItem.title = "FLIGHT"

        self.activityIndicator.center = self.view.center
  
        self.activityIndicator.hidesWhenStopped = true
        
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(self.activityIndicator)
        
        loadData()
        //self.navigationController?.navigationBarHidden = true
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func loadData()
    {
        let currentUser = PFUser.currentUser()
        if currentUser == nil {
            
            
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

            passwordField.bounds = CGRect(x: 0, y: 0, width: view.bounds.width-50, height: 40)
            passwordField.center = CGPoint(x: view.bounds.width / 2, y: self.view.frame.size.height - 230)
            passwordField.placeholder = "Password"
            passwordField.font = UIFont.systemFontOfSize(15)
            passwordField.borderStyle = UITextBorderStyle.RoundedRect
            passwordField.autocorrectionType = UITextAutocorrectionType.No
            passwordField.keyboardType = UIKeyboardType.Default
            passwordField.returnKeyType = UIReturnKeyType.Done
            passwordField.clearButtonMode = UITextFieldViewMode.WhileEditing;
            passwordField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
            passwordField.delegate = self
            passwordField.secureTextEntry = true
            self.view.addSubview(passwordField)
            
            /*login_button.bounds = CGRect(x: 0, y: 0, width: view.bounds.width, height: 80)
            login_button.center = CGPoint(x: view.bounds.width / 2, y: self.view.frame.size.height - 180)
            
            login_button.setBackgroundImage(UIImage(named: "Icon-Spotlight-40"), forState: UIControlState.Normal)
            login_button.titleLabel?.font = UIFont.systemFontOfSize(20)
            login_button.setTitleColor(UIColor.whiteColor(), forState:  UIControlState.Normal)*/
            
            
            //login_button.frame = CGRectMake(100, 300, 120, 50)
            //login_button.backgroundColor = UIColor.clearColor()
            //login_button.setTitle("Login", forState: UIControlState.Normal)
            //login_button.addTarget(self, action: #selector(CustomloginViewController.loginButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            //self.view.addSubview(login_button)
            
            login_button.bounds = CGRect(x: 0, y: 0, width: view.bounds.width - 30, height: 80)
            login_button.center = CGPoint(x: view.bounds.width / 2, y: self.view.frame.size.height - 150)
            login_button.setBackgroundImage(UIImage(named: "Icon-Spotlight-40"), forState: UIControlState.Normal)
            login_button.titleLabel?.font = UIFont.systemFontOfSize(20)
            login_button.setTitleColor(UIColor.whiteColor(), forState:  UIControlState.Normal)
            login_button.setTitle("Login", forState: UIControlState.Normal)
            login_button.addTarget(self, action: #selector(CustomloginViewController.loginButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(login_button)

            
            
            //signup_button.frame = CGRectMake(100, 330, 120, 50)
            //signup_button.backgroundColor = UIColor.clearColor()
            //signup_button.setTitle("Sign Up", forState: UIControlState.Normal)
            //signup_button.addTarget(self, action: #selector(CustomloginViewController.signupButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            //self.view.addSubview(signup_button)
            //print("Duuuude")
            
            
            signup_button.bounds = CGRect(x: 0, y: 0, width: view.bounds.width - 30, height: 80)
            signup_button.center = CGPoint(x: view.bounds.width / 2, y: self.view.frame.size.height - 60)
            signup_button.setBackgroundImage(UIImage(named: "Icon-Spotlight-40"), forState: UIControlState.Normal)
            signup_button.titleLabel?.font = UIFont.systemFontOfSize(20)
            signup_button.setTitleColor(UIColor.whiteColor(), forState:  UIControlState.Normal)
            signup_button.setTitle("Sign Up", forState: UIControlState.Normal)
            signup_button.addTarget(self, action: #selector(CustomloginViewController.signupButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(signup_button)

            
            
            self.tabBarController?.tabBar.hidden = true
            
            
            
        } else {
            
            start_button.bounds = CGRect(x: 0, y: 0, width: view.bounds.width - 30, height: 80)
            start_button.center = CGPoint(x: view.bounds.width / 2, y: self.view.frame.size.height - 290)
            start_button.setBackgroundImage(UIImage(named: "Icon-Spotlight-40"), forState: UIControlState.Normal)
            start_button.titleLabel?.font = UIFont.systemFontOfSize(20)
            start_button.setTitleColor(UIColor.whiteColor(), forState:  UIControlState.Normal)
            start_button.setTitle("Start Flight", forState: UIControlState.Normal)
            start_button.addTarget(self, action: #selector(CustomloginViewController.startButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(start_button)
            
            
            change_button.bounds = CGRect(x: 0, y: 0, width: view.bounds.width - 30, height: 80)
            change_button.center = CGPoint(x: view.bounds.width / 2, y: self.view.frame.size.height - 200)
            change_button.setBackgroundImage(UIImage(named: "Icon-Spotlight-40"), forState: UIControlState.Normal)
            change_button.titleLabel?.font = UIFont.systemFontOfSize(20)
            change_button.setTitleColor(UIColor.whiteColor(), forState:  UIControlState.Normal)
            change_button.setTitle("Change Airplane", forState: UIControlState.Normal)
            change_button.addTarget(self, action: #selector(CustomloginViewController.changeButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(change_button)
            
            
            signout_button.bounds = CGRect(x: 0, y: 0, width: view.bounds.width - 30, height: 80)
            signout_button.center = CGPoint(x: view.bounds.width / 2, y: self.view.frame.size.height - 110)
            signout_button.setBackgroundImage(UIImage(named: "Icon-Spotlight-40"), forState: UIControlState.Normal)
            signout_button.titleLabel?.font = UIFont.systemFontOfSize(20)
            signout_button.setTitleColor(UIColor.whiteColor(), forState:  UIControlState.Normal)
            signout_button.setTitle("Sign out", forState: UIControlState.Normal)
            signout_button.addTarget(self, action: #selector(CustomloginViewController.signoutButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(signout_button)
            self.tabBarController?.tabBar.hidden = false
        }
        
        
    }
    
    
    func loginButtonAction(sender:UIButton!)
    {
        let username = self.usernameField.text
        let password = self.passwordField.text
        //var currentUser = PFUser.currentUser()!.username
        
        if (username!.utf16.count < 4 || password!.utf16.count < 5){
            
            let alert = UIAlertView(title: "Invalid", message: "Username must be greater then 4 and password must be greater then 5.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }
        else {
            
            self.activityIndicator.startAnimating()
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: {(user, error) -> Void in
                self.activityIndicator.stopAnimating()
                
                if ((user) != nil){
                    let alert = UIAlertView(title: "Succes \n Your name is \(username!)", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    self.tabBarController?.tabBar.hidden = false
                    self.loadData()                             //reload the page to change buttons
                    self.usernameField.removeFromSuperview()
                    self.passwordField.removeFromSuperview()
                    self.login_button.removeFromSuperview()
                    self.signup_button.removeFromSuperview()
                    //UIApplication.sharedApplication().keyWindow?.rootViewController = self.storyboard!.instantiateViewControllerWithIdentifier("view")
                    
                }
                else{
                    let alert = UIAlertView(title: "Error ", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
                
            })
            
            
        }
    }
    
    
    func signupButtonAction(sender:UIButton!)
    {
        self.performSegueWithIdentifier("signup", sender: self)
    }
    
    
    func startButtonAction(sender:UIButton!)
    {
        
        let query = PFQuery(className: "Aircrafts")
        let currentUser = PFUser.currentUser()
        query.whereKey("User", equalTo: currentUser!)
        //query.whereKey("Type", equalTo: "CPL") imi intoarce doar anumite linii
        //query.selectKeys("Type") doar coloana asta
        //query.orderByAscending("Type")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil{
                //there was no error in the fetch
                if let returnedobjects = objects {
                    var cnt = 0
                    for object in returnedobjects{
                        if object["CurrentAirplane"] as! Int == 0{
                            cnt += 1
                        }
                    }
                    if cnt == returnedobjects.count{
                        self.performSegueWithIdentifier("chooseAirplane", sender: self)
                    }
                    else{
                        self.performSegueWithIdentifier("mapView", sender: self)
                    }
                }
            }
        }
        

        
            }
    
    func changeButtonAction(sender:UIButton!)
    {
        self.performSegueWithIdentifier("changeAirplaneSegue", sender: self)
    }
    
    func signoutButtonAction(sender:UIButton!)
    {
        PFUser.logOut()
        let alert = UIAlertView(title: "Success", message: "You are now logged out.", delegate: self, cancelButtonTitle: "OK")
        alert.show()
        signout_button.removeFromSuperview()
        change_button.removeFromSuperview()
        start_button.removeFromSuperview()
        //UIApplication.sharedApplication().keyWindow?.rootViewController = storyboard!.instantiateViewControllerWithIdentifier("view")
        self.view.window!.rootViewController?.dismissViewControllerAnimated(false, completion: nil)
        loadData()
    }

    
    
/*    @IBAction func loginAction(sender: AnyObject) {
        
        let username = self.usernameField.text
        let password = self.passwordField.text
        //var currentUser = PFUser.currentUser()!.username
        
        if (username!.utf16.count < 4 || password!.utf16.count < 5){
            
            let alert = UIAlertView(title: "Invalid", message: "Username must be greater then 4 and password must be greater then 5.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }
        else {
            
            self.activityIndicator.startAnimating()
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: {(user, error) -> Void in
                self.activityIndicator.stopAnimating()
                
                if ((user) != nil){
                    let alert = UIAlertView(title: "Succes \n Your name is \(username!)", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    self.performSegueWithIdentifier("Userconnection", sender: self)
                }
                else{
                    let alert = UIAlertView(title: "Error ", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
                
            })
            
            
        }
    }
    

    
    @IBAction func signUpAction(sender: AnyObject) {
        self.performSegueWithIdentifier("signup", sender: self)
    }
    */
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
