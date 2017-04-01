//
//  ViewController.swift
//  CustomLogin
//
//  Created by Alexandra Lazea on 25/02/16.
//  Copyright © 2016 Medeea. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController {

   //test commit
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var sometext: UITextView!
    
    let login_button = UIButton(type: UIButtonType.System)
    let signup_button = UIButton(type: UIButtonType.System)
    let start_button = UIButton(type: UIButtonType.System)
    let change_button = UIButton(type: UIButtonType.System)
    let signout_button = UIButton(type: UIButtonType.System)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.navigationItem.title = "FLIGHT"
        
        loadData()
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Actions
    
    
    func loadData()
    {
        let currentUser = PFUser.currentUser()
        if currentUser == nil {
            
            login_button.frame = CGRectMake(100, 100, 120, 50)
            login_button.backgroundColor = UIColor.clearColor()
            login_button.setTitle("Login", forState: UIControlState.Normal)
            login_button.addTarget(self, action: "loginButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(login_button)
            
            
            
        } else {
            
            start_button.frame = CGRectMake(100, 100, 120, 50)
            start_button.backgroundColor = UIColor.clearColor()
            start_button.setTitle("Start Flight", forState: UIControlState.Normal)
            start_button.addTarget(self, action: "startButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(start_button)
            
            
            change_button.frame = CGRectMake(100, 150, 120, 50)
            change_button.backgroundColor = UIColor.clearColor()
            change_button.setTitle("Change Airplane", forState: UIControlState.Normal)
            change_button.addTarget(self, action: "changeButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(change_button)
            
            
            signout_button.frame = CGRectMake(100, 200, 120, 50)
            signout_button.backgroundColor = UIColor.clearColor()
            signout_button.setTitle("Sign out", forState: UIControlState.Normal)
            signout_button.addTarget(self, action: "signoutButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(signout_button)
            print("Esti logat duude")
            
        }

        
    }
    
    func loginButtonAction(sender:UIButton!)
    {
        self.performSegueWithIdentifier("Custom", sender: self)
    }

    func startButtonAction(sender:UIButton!)
    {
        self.performSegueWithIdentifier("Custom", sender: self)
    }
    
    func changeButtonAction(sender:UIButton!)
    {
        self.performSegueWithIdentifier("Custom", sender: self)
    }
    
    func signoutButtonAction(sender:UIButton!)
    {
        PFUser.logOut()
        let alert = UIAlertView(title: "Success", message: "You are now logged out.", delegate: self, cancelButtonTitle: "OK")
        alert.show()
        signout_button.removeFromSuperview()
        change_button.removeFromSuperview()
        start_button.removeFromSuperview()
        
        loadData()
    }

}

