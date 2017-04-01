//
//  add_selectAirplaneViewController.swift
//  CustomLogin
//
//  Created by Alexandra Lazea on 08/04/16.
//  Copyright © 2016 Medeea. All rights reserved.
//

import UIKit
import Parse

class add_selectAirplaneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView1: UITableView  =   UITableView()
    var retobj = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView1.frame         =   CGRect(x: 0, y: 200, width: 320, height: 500);
        tableView1.delegate      =   self
        tableView1.dataSource    =   self
        
        tableView1.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        //Retrive all the data from the class
        
        let query = PFQuery(className: "Aircrafts")
        let currentUser = PFUser.current()
        query.whereKey("User", equalTo: currentUser!)
        query.findObjectsInBackground { (objects, error) -> Void in
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "addNewPlane") {
            let svc = segue.destination as! AddAirplaneViewController;
            svc.fromAddSelectAirplane = 1
            
        }
    }
    
    @IBAction func addAirplane(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "addNewPlane", sender: self)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.retobj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView1.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
            if self.retobj.count == 0{
                cell.textLabel?.text = "You don't have any airplane added yet."
            }
            else{
                let va = self.retobj[indexPath.row]["Type"] as! String
                cell.textLabel?.text = va
            }
    return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 //number of sections in the table
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Select from the list"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let query = PFQuery(className: "Aircrafts")
        query.whereKey("objectId", equalTo: self.retobj[indexPath.row].objectId!)
        query.findObjectsInBackground { (objects, error) -> Void in
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
        alert.addButton(withTitle: "OK")
        alert.show()
        self.performSegue(withIdentifier: "mapView1", sender: self)
    }
    
    


}
