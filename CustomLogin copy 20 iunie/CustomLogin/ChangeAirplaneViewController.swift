//
//  ChangeAirplaneViewController.swift
//  CustomLogin
//
//  Created by Alexandra Lazea on 09/04/16.
//  Copyright © 2016 Medeea. All rights reserved.
//

import UIKit
import Parse

class ChangeAirplaneViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    var tableView1: UITableView  =   UITableView()
    var retobj = [PFObject]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.navigationItem.title = "CHANGE AIRPLANE"
        
        tableView1.frame         =   CGRectMake(0, 65, 320, 500); //a doua e marginTop
        tableView1.delegate      =   self
        tableView1.dataSource    =   self
        
        tableView1.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        //Retrive all the data from the class
        
        let query = PFQuery(className: "Aircrafts")
        let currentUser = PFUser.currentUser()
        query.whereKey("User", equalTo: currentUser!)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil{
                //there was no error in the fetch
                if let returnedobjects = objects {
                    
                    self.retobj = returnedobjects
                    self.view.addSubview(self.tableView1)
                    //objects array isn't nil
                    //loop through the array to get each object
                    //for object in returnedobjects{
                    //    print(object["Type"] as! String)
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.retobj.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView1.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        if self.retobj.count == 0{
            cell.textLabel?.text = "You don't have any airplane added yet."
        }
        else{
            let va = self.retobj[indexPath.row]["Type"] as! String
            cell.textLabel?.text = va
        }
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 //number of sections in the table
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select from the list"
    }
    
    func beforeChange(){
        
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
                    for object in returnedobjects{
                        object["CurrentAirplane"] = 0
                        object.saveInBackground()
                    }
                }
            }
        }
        
    }

    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let query = PFQuery(className: "Aircrafts")
        query.whereKey("objectId", equalTo: self.retobj[indexPath.row].objectId!)
        beforeChange()
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil{
                //there was no error in the fetch
                if let returnedobjects = objects {
                    for object in returnedobjects{
                        object["CurrentAirplane"] = 1
                        object.saveInBackground()
                    }
                }
            }
        }
        
        
        
        let alert = UIAlertView()
        alert.delegate = self
        alert.title = "Your current airplane is"
        alert.message = "\(self.retobj[indexPath.row]["Type"] as! String)"
        alert.addButtonWithTitle("OK")
        alert.show()
        self.performSegueWithIdentifier("changeAirplaneToMainPage", sender: self)
    }


}