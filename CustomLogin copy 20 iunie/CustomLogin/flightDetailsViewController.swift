//
//  flightDetailsViewController.swift
//  CustomLogin
//
//  Created by Alexandra Lazea on 19/04/16.
//  Copyright © 2016 Medeea. All rights reserved.
//

import UIKit
import Parse

class flightDetailsViewController: UIViewController {
    
    var tableView1: UITableView  =   UITableView()
    var retobj = [PFObject]()
    
    
    var flightID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
         self.navigationItem.title = "FLIGHT DETAILS"
        
        //tableView1.frame         =   CGRectMake(0, 65, 320, 500); //a doua e marginTop
        //tableView1.delegate      =   self
        //tableView1.dataSource    =   self
        
        tableView1.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        //Retrive all the data from the class
        
        let query = PFQuery(className: "Flight")
        //let currentUser = PFUser.currentUser()
        //query.whereKey("User", equalTo: currentUser!)
        query.whereKey("objectId", equalTo: flightID)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil{
                //there was no error in the fetch
                if let returnedobjects = objects {
                    //objects array isn't nil
                    //loop through the array to get each object
                    for object in returnedobjects{
                        //let dateFormatter = NSDateFormatter()
                        //dateFormatter.dateFormat = "dd-MM-YYYY"
                        //let dateString = dateFormatter.stringFromDate(object["date"] as! NSDate)
                        var i : CGFloat = 65
                        var label = UILabel(frame: CGRectMake(0, i, 300, 21))
                        label.text = "Date: " + (object["date"] as! String)
                        self.view.addSubview(label)
                        i = i + 25
                        label = UILabel(frame: CGRectMake(0, i, 300, 21))
                        label.text = "Aircraft: " + (object["airplane"] as! String)
                        self.view.addSubview(label)
                        i = i + 25
                        label = UILabel(frame: CGRectMake(0, i, 300, 21))
                        label.text = "Registration: " + (object["registration"] as! String)
                        self.view.addSubview(label)
                        i = i + 25
                        label = UILabel(frame: CGRectMake(0, i, 300, 21))
                        label.text = "Take off time: " + (object["takeOff"] as! String)
                        self.view.addSubview(label)
                        
                        i = i + 25
                        label = UILabel(frame: CGRectMake(0, i, 300, 21))
                        label.text = "Landing time: " + (object["landing"] as! String)
                        self.view.addSubview(label)
                        
                        i = i + 25
                        label = UILabel(frame: CGRectMake(0, i, 300, 21))
                        label.text = "In air time: " + (object["inAirTime"] as! String)
                        self.view.addSubview(label)
                        
                        i = i + 25
                        label = UILabel(frame: CGRectMake(0, i, 300, 21))
                        label.text = "Take off coordinates: "
                        self.view.addSubview(label)
                        
                        i = i + 25
                        
                        label = UILabel(frame: CGRectMake(0, i, 300, 21))
                        label.text = "\(object["takeOffLatitude"] as! NSNumber)" + "  " + "\(object["takeOffLongitude"] as! NSNumber)"
                        self.view.addSubview(label)

                        
                        if let toc = object["takeOffCity"] as? String{
                            if toc != "Location"{
                            i = i + 25
                            label = UILabel(frame: CGRectMake(0, i, 300, 21))
                            label.text = toc
                            self.view.addSubview(label)
                            }}
                        i = i + 25
                        label = UILabel(frame: CGRectMake(0, i, 300, 21))
                        label.text = "Landing coordinates: "
                        self.view.addSubview(label)
                        
                        i = i + 25
                        label = UILabel(frame: CGRectMake(0, i, 300, 21))
                        label.text = "\(object["landingLatitude"] as! NSNumber)" + " " + "\(object["landingLongitude"] as! NSNumber)"
                        self.view.addSubview(label)
                        

                        
                        if let lc = object["landingCity"] as? String{
                            if lc != "Location"{
                            i = i + 25
                            label = UILabel(frame: CGRectMake(0, i, 300, 21))
                            label.text = lc
                            self.view.addSubview(label)
                            }}
                        
                                            }
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
    /*
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.retobj.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView1.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        if self.retobj.count == 0{
            cell.textLabel?.text = "You don't have any airplane added yet."
        }
        else{
            let va = self.retobj[indexPath.row]["airplane"] as! String
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

    
    */

}
