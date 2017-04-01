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
    
    let login_button = UIButton(type: UIButtonType.system)
    let signup_button = UIButton(type: UIButtonType.system)
    let start_button = UIButton(type: UIButtonType.system)
    let change_button = UIButton(type: UIButtonType.system)
    let signout_button = UIButton(type: UIButtonType.system)
    
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
        let currentUser = PFUser.current()
        if currentUser == nil {
            
            login_button.frame = CGRect(x: 100, y: 100, width: 120, height: 50)
            login_button.backgroundColor = UIColor.clear
            login_button.setTitle("Login", for: UIControlState())
            login_button.addTarget(self, action: #selector(ViewController.loginButtonAction(_:)), for: UIControlEvents.touchUpInside)
            self.view.addSubview(login_button)
            
            
            
        } else {
            
            start_button.frame = CGRect(x: 100, y: 100, width: 120, height: 50)
            start_button.backgroundColor = UIColor.clear
            start_button.setTitle("Start Flight", for: UIControlState())
            start_button.addTarget(self, action: #selector(ViewController.startButtonAction(_:)), for: UIControlEvents.touchUpInside)
            self.view.addSubview(start_button)
            
            
            change_button.frame = CGRect(x: 100, y: 150, width: 120, height: 50)
            change_button.backgroundColor = UIColor.clear
            change_button.setTitle("Change Airplane", for: UIControlState())
            change_button.addTarget(self, action: #selector(ViewController.changeButtonAction(_:)), for: UIControlEvents.touchUpInside)
            self.view.addSubview(change_button)
            
            
            signout_button.frame = CGRect(x: 100, y: 200, width: 120, height: 50)
            signout_button.backgroundColor = UIColor.clear
            signout_button.setTitle("Sign out", for: UIControlState())
            signout_button.addTarget(self, action: #selector(ViewController.signoutButtonAction(_:)), for: UIControlEvents.touchUpInside)
            self.view.addSubview(signout_button)
            print("Esti logat duude")
            
        }

        
    }
    
    func loginButtonAction(_ sender:UIButton!)
    {
        self.performSegue(withIdentifier: "Custom", sender: self)
    }

    func startButtonAction(_ sender:UIButton!)
    {
        self.performSegue(withIdentifier: "Custom", sender: self)
    }
    
    func changeButtonAction(_ sender:UIButton!)
    {
        self.performSegue(withIdentifier: "Custom", sender: self)
    }
    
    func signoutButtonAction(_ sender:UIButton!)
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

