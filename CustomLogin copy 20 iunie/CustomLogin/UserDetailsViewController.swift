//
//  UserDetailsViewController.swift
//  CustomLogin
//
//  Created by Alexandra Lazea on 27/02/16.
//  Copyright © 2016 Medeea. All rights reserved.
//

import UIKit
import Parse

class UserDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var tableView1: UITableView  =   UITableView()
    var tableView2: UITableView  =   UITableView()
    var retobj = [PFObject]()
    var retobj1 = [PFObject]()

    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        
        let addAirplaneButton   = UIButton(type: UIButtonType.System) as UIButton
        addAirplaneButton.bounds = CGRect(x: 0, y: 0, width: view.bounds.width - 30, height: 80)
        addAirplaneButton.center = CGPoint(x: view.bounds.width / 2, y: 120)
        addAirplaneButton.setBackgroundImage(UIImage(named: "Icon-Spotlight-40"), forState: UIControlState.Normal)
        addAirplaneButton.titleLabel?.font = UIFont.systemFontOfSize(20)
        addAirplaneButton.setTitleColor(UIColor.whiteColor(), forState:  UIControlState.Normal)
        addAirplaneButton.setTitle("Add Aircraft", forState: UIControlState.Normal)
        addAirplaneButton.addTarget(self, action: #selector(UserDetailsViewController.addToDatabase(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview( addAirplaneButton)

        let addLicence  = UIButton(type: UIButtonType.System) as UIButton
        addLicence.bounds = CGRect(x: 0, y: 0, width: view.bounds.width - 30, height: 80)
        addLicence.center = CGPoint(x: view.bounds.width / 2, y: 210)
        addLicence.setBackgroundImage(UIImage(named: "Icon-Spotlight-40"), forState: UIControlState.Normal)
        addLicence.titleLabel?.font = UIFont.systemFontOfSize(20)
        addLicence.setTitleColor(UIColor.whiteColor(), forState:  UIControlState.Normal)
        addLicence.setTitle("Add Licence", forState: UIControlState.Normal)
        addLicence.addTarget(self, action: #selector(UserDetailsViewController.addLicencetoDatabase(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(addLicence)
        
        self.navigationItem.title = "PROFILE"
        
        self.tabBarController?.tabBar.hidden = false
        
        addAirplaneButton.tag = 12
 
        
        tableView1.frame         =   CGRectMake(15, 265, view.bounds.width - 30, 500);
        tableView1.delegate      =   self
        tableView1.dataSource    =   self
        
        tableView1.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        //Retrive all the data from the class
        
        var query = PFQuery(className: "Licence")
        let currentUser = PFUser.currentUser()
        query.whereKey("User", equalTo: currentUser!)
        //query.whereKey("Type", equalTo: "CPL") imi intoarce doar anumite linii
        //query.selectKeys("Type") doar coloana asta
        //query.orderByAscending("Type")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil{
                //there was no error in the fetch
                if let returnedobjects = objects {
                    
                    self.retobj = returnedobjects
                    self.view.addSubview(self.tableView1)
                    //objects array isn't nil
                    //loop through the array to get each object
                    for object in returnedobjects{
                        print(object["Type"] as! String)
                    }
                }
            }
        }
        
        
        query = PFQuery(className: "Aircrafts")
        query.whereKey("User", equalTo: currentUser!)
        //query.whereKey("Type", equalTo: "CPL") imi intoarce doar anumite linii
        //query.selectKeys("Type") doar coloana asta
        //query.orderByAscending("Type")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil{
                //there was no error in the fetch
                if let returnedobjects = objects {
                    
                    self.retobj1 = returnedobjects
                    self.tableView1.reloadData()
                    //objects array isn't nil
                    //loop through the array to get each object
                    for object in returnedobjects{
                        print(object["Type"] as! String)
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var query = PFQuery(className: "Licence")
        let currentUser = PFUser.currentUser()
        query.whereKey("User", equalTo: currentUser!)
        //query.whereKey("Type", equalTo: "CPL") imi intoarce doar anumite linii
        //query.selectKeys("Type") doar coloana asta
        //query.orderByAscending("Type")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil{
                //there was no error in the fetch
                if let returnedobjects = objects {
                    
                    self.retobj = returnedobjects
                    self.tableView1.reloadData()
                    //objects array isn't nil
                    //loop through the array to get each object
                    //for object in returnedobjects{
                      //  print(object["Type"] as! String)
                    //}
                }
            }
        }
        
        
        query = PFQuery(className: "Aircrafts")
        query.whereKey("User", equalTo: currentUser!)
        //query.whereKey("Type", equalTo: "CPL") imi intoarce doar anumite linii
        //query.selectKeys("Type") doar coloana asta
        //query.orderByAscending("Type")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil{
                //there was no error in the fetch
                if let returnedobjects = objects {
                    
                    self.retobj1 = returnedobjects
                    self.tableView1.reloadData()
                    //objects array isn't nil
                    //loop through the array to get each object
                    //for object in returnedobjects{
                    //print(object["Type"] as! String)
                    //}
                }
            }
        }
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "addAirplane") {
            let svc = segue.destinationViewController as! AddAirplaneViewController;
            svc.fromUserDetails = 1
            
        }
    }
    
    @IBAction func addToDatabase(sender: AnyObject) {
        self.performSegueWithIdentifier("addAirplane", sender: sender)
    }
    
    
    @IBAction func addLicencetoDatabase(sender: UIButton) {
        self.performSegueWithIdentifier("addlicence", sender: self)
    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { //prima sectiune
                        if self.retobj.count == 0{
                return 1
            }
            else{
                return self.retobj.count
            }
           
        }
        else{ //lungime a doua sectiune
            if self.retobj1.count == 0{
                return 1
            }
            else{
                return self.retobj1.count
            }
            
        }
    }
    
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let cell:UITableViewCell = tableView1.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        if indexPath.section == 0{  //daca sunt in prima sectiune imi ia din prima lists
            if self.retobj.count == 0{
                cell.textLabel?.text = "You don't have any licence added yet."
                cell.backgroundColor = hexStringToUIColor("#D7D7D7")
                
            }
            else{
                let va = self.retobj[indexPath.row]["Type"] as! String
                cell.textLabel?.text = va
                cell.backgroundColor = hexStringToUIColor("#D7D7D7")
            }
            
        }
        else{ //a doua sectiune -> a doua lista
            if self.retobj1.count == 0{
                cell.textLabel?.text = "You don't have any aircraft added yet."
                cell.backgroundColor = hexStringToUIColor("#D7D7D7")
            }
            else{
                let va = self.retobj1[indexPath.row]["Type"] as! String
                cell.textLabel?.text = va
                cell.backgroundColor = hexStringToUIColor("#D7D7D7")
            }
        }
        return cell
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Licences"
        }
        else{
            return "Aircrafts"
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
