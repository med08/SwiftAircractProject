//
//  allFlightsViewController.swift
//  CustomLogin
//
//  Created by Alexandra Lazea on 18/04/16.
//  Copyright © 2016 Medeea. All rights reserved.
//

import UIKit
import Parse

class allFlightsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    var tableView1: UITableView  =   UITableView()
    var retobj = [PFObject]()
    var fllightID = ""
    var custom = 0
    var searchParameters: [String] = [String]()
    var searchDate: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "FLIGHTS"
        
        tableView1.frame         =   CGRect(x: 0, y: 140, width: view.bounds.width, height: 500); //a doua e marginTop
        tableView1.delegate      =   self
        tableView1.dataSource    =   self
        
        tableView1.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView1.tableFooterView = UIView()
        
        let label = UILabel()
        label.bounds = CGRect(x: 0, y: 0, width: view.bounds.width, height: 80)
        label.center = CGPoint(x: view.bounds.width / 2, y: 100)
        label.backgroundColor = UIColor(patternImage: UIImage(named: "Icon-Spotlight-40")!)
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.text = "Your flights:"
        self.view.addSubview(label)
        
        //Retrive all the data from the class
        
        
        if custom == 0{
            let query = PFQuery(className: "Flight")
            let currentUser = PFUser.current()
            query.whereKey("user", equalTo: currentUser!)
            query.findObjectsInBackground { (objects, error) -> Void in
                if error == nil{
                    //there was no error in the fetch
                    if let returnedobjects = objects {
                        
                        self.retobj = returnedobjects
                        self.view.addSubview(self.tableView1)
                        //objects array isn't nil
                        //loop through the array to get each object
                        /*for object in returnedobjects{
                            print(object["inAirTime"] as! String)
                         }*/
                    }
                }
            }
        }
        else{
            
            let query = PFQuery(className: "Flight")
            let currentUser = PFUser.current()
            query.whereKey("user", equalTo: currentUser!)
            
            if searchParameters[0] != "Any day"{
                if searchParameters[1] != "Any month"{
                     if searchParameters[2] != "Any year"{
                        if searchParameters[3] != "Any airplane"{
                            query.whereKey("date", contains: searchParameters[0]+"-"+searchParameters[1]+"-"+searchParameters[2]).whereKey( "registration", equalTo: searchParameters[3])
                            
                        }
                        else{
                            query.whereKey("date", contains: searchParameters[0]+"-"+searchParameters[1]+"-"+searchParameters[2])
                        }
                    }
                     else{
                        if searchParameters[3] != "Any airplane"{
                            query.whereKey("date", contains: searchParameters[0]+"-"+searchParameters[1]+"-").whereKey( "registration", equalTo: searchParameters[3])
                        }
                        else{
                             query.whereKey("date", contains: searchParameters[0]+"-"+searchParameters[1]+"-")
                        }
                        
                    }
                }
                else{
                    if searchParameters[2] != "Any year"{
                        if searchParameters[3] != "Any airplane"{
                             query.whereKey("date", contains: searchParameters[0]+"-").whereKey("date", contains: "-"+searchParameters[2]).whereKey( "registration", equalTo: searchParameters[3])
                        }
                        else{
                            query.whereKey("date", contains: searchParameters[0]+"-").whereKey("date", contains: "-"+searchParameters[2])
                        }
                        
                    }
                    else{
                        if searchParameters[3] != "Any airplane"{
                            query.whereKey("date", contains: searchParameters[0]+"-").whereKey( "registration", equalTo: searchParameters[3])
                        }
                        else{
                            query.whereKey("date", contains: searchParameters[0]+"-")                        }
                    }
                }
            }
            else{
                if searchParameters[1] != "Any month"{
                    if searchParameters[2] != "Any year"{
                        if searchParameters[3] != "Any airplane"{
                            query.whereKey("date", contains: "-"+searchParameters[1]+"-"+searchParameters[2]).whereKey( "registration", equalTo: searchParameters[3])
                            
                        }
                        else{
                            query.whereKey("date", contains: "-"+searchParameters[1]+"-"+searchParameters[2])
                        }
                    }
                    else{
                        if searchParameters[3] != "Any airplane"{
                            query.whereKey("date", contains: "-"+searchParameters[1]+"-").whereKey( "registration", equalTo: searchParameters[3])
                        }
                        else{
                            query.whereKey("date", contains: "-"+searchParameters[1]+"-")
                        }
                        
                    }
                }
                else{
                    if searchParameters[2] != "Any year"{
                        if searchParameters[3] != "Any airplane"{
                            query.whereKey("date", contains: "-"+searchParameters[2]).whereKey( "registration", equalTo: searchParameters[3])
                        }
                        else{
                            query.whereKey("date", contains: "-"+searchParameters[2])
                        }
                        
                    }
                    else{
                        if searchParameters[3] != "Any airplane"{
                            query.whereKey("date", contains: "-"+searchParameters[2]).whereKey( "registration", equalTo: searchParameters[3])
                        }
                    }
                }

            }
            

            
            query.findObjectsInBackground { (objects, error) -> Void in
                if error == nil{
                    //there was no error in the fetch
                    if let returnedobjects = objects {
                        
                        self.retobj = returnedobjects
                        self.view.addSubview(self.tableView1)
                        //objects array isn't nil
                        //loop through the array to get each object
                        /*for object in returnedobjects{
                         print(object["inAirTime"] as! String)
                         }*/
                    }
                }
            }

        }
        self.automaticallyAdjustsScrollViewInsets = false
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.retobj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView1.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        if self.retobj.count == 0{
            cell.textLabel?.text = "You don't have any flights yet."
        }
        else{
            var va = self.retobj[indexPath.row]["inAirTime"] as! String
           // let dateFormatter = NSDateFormatter()
           // dateFormatter.dateFormat = "dd-MM-YYYY"
           // let dateString = dateFormatter.stringFromDate(self.retobj[indexPath.row]["date"] as! NSDate)
            va = va + " min" + "   " + (self.retobj[indexPath.row]["date"] as! String)
            cell.textLabel?.text = va
            cell.imageView?.image = UIImage(named: "airplane_mode_on-25")
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 //number of sections in the table
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "flightDetails") {
            let svc = segue.destination as! flightDetailsViewController;
            svc.flightID = fllightID
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fllightID = "\(self.retobj[indexPath.row].objectId!)"
        self.performSegue(withIdentifier: "flightDetails", sender: self)
    }
    
    
    
    
}



