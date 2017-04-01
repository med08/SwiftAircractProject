//
//  FirstLoginViewController.swift
//  CustomLogin
//
//  Created by Alexandra Lazea on 27/02/16.
//  Copyright © 2016 Medeea. All rights reserved.
//

import UIKit
import Parse

class FirstLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // let currentUser = PFUser.currentUser()
        //if currentUser != nil {
            self.performSegueWithIdentifier("loginToFirstView", sender: self)

        //}
        //else
        //{}

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

    @IBAction func magicButton(sender: AnyObject) {
        self.performSegueWithIdentifier("loginToFirstView", sender: self)
    }
}
