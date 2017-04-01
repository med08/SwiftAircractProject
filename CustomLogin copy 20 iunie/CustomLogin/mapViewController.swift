//
//  mapViewController.swift
//  CustomLogin
//
//  Created by Alexandra Lazea on 25/03/16.
//  Copyright © 2016 Medeea. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Parse

class mapViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var inAirTime: UILabel!
    @IBOutlet weak var mapView: MKMapView!

   // @IBOutlet weak var groundAltitude: UILabel!
    @IBOutlet weak var myAltitude: UILabel!
    
    @IBOutlet weak var myLatitude: UILabel!
    @IBOutlet weak var myLongitude: UILabel!
    @IBOutlet weak var myLocationView: UILabel!
    
 /*   var inAirTime = UILabel()
    var myAltitude = UILabel()
    var myLongitude = UILabel()
    var myLatitude = UILabel()
     var myLocationView = UILabel()
 
  */
    var departureSwitch = 0
    var takeOffTime = NSDate()
    var atLeastOneTime = 0
    var takeOffCity = ""
    var currentAirplane = ""
    var currentAirplaneReg = ""
    var takeOffLatitude = 0.0
    var takeOffLongitude = 0.0
    var landingLatitude = 0.0
    var landingLongitude = 0.0
    
    var locationManager:CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       /*
        inAirTime.bounds = CGRect(x: 0, y: 0, width: view.bounds.width, height: 80)
        inAirTime.center = CGPoint(x: view.bounds.width / 2, y: 100)
        inAirTime.backgroundColor = UIColor(patternImage: UIImage(named: "Icon-Spotlight-40")!)
        inAirTime.font = UIFont.systemFontOfSize(20)
        inAirTime.textColor = UIColor.whiteColor()
        inAirTime.textAlignment = NSTextAlignment.Center
        self.view.addSubview(inAirTime)
        
        myAltitude.bounds = CGRect(x: 0, y: 0, width: view.bounds.width - 30, height: 80)
        myAltitude.center = CGPoint(x: view.bounds.width / 2, y: 370)
        myAltitude.backgroundColor = UIColor(patternImage: UIImage(named: "Icon-Spotlight-40")!)
        myAltitude.font = UIFont.systemFontOfSize(20)
        myAltitude.textColor = UIColor.whiteColor()
        myAltitude.textAlignment = NSTextAlignment.Center
        
        myLongitude.bounds = CGRect(x: 0, y: 0, width: view.bounds.width - 30, height: 80)
        myLongitude.center = CGPoint(x: view.bounds.width / 2, y: 340)
        myLongitude.backgroundColor = UIColor(patternImage: UIImage(named: "Icon-Spotlight-40")!)
        myLongitude.font = UIFont.systemFontOfSize(20)
        myLongitude.textColor = UIColor.whiteColor()
        myLongitude.textAlignment = NSTextAlignment.Center
        
        myLatitude.bounds = CGRect(x: 0, y: 0, width: view.bounds.width - 30, height: 80)
        myLatitude.center = CGPoint(x: view.bounds.width / 2, y: 300)
        myLatitude.backgroundColor = UIColor(patternImage: UIImage(named: "Icon-Spotlight-40")!)
        myLatitude.font = UIFont.systemFontOfSize(20)
        myLatitude.textColor = UIColor.whiteColor()
        myLatitude.textAlignment = NSTextAlignment.Center
        
        myLocationView.bounds = CGRect(x: 0, y: 0, width: view.bounds.width - 30, height: 80)
        myLocationView.center = CGPoint(x: view.bounds.width / 2, y: 300)
        myLocationView.backgroundColor = UIColor(patternImage: UIImage(named: "Icon-Spotlight-40")!)
        myLocationView.font = UIFont.systemFontOfSize(20)
        myLocationView.textColor = UIColor.whiteColor()
        myLocationView.textAlignment = NSTextAlignment.Center
*/
        
         self.navigationItem.title = "FLYING"
        
        let query = PFQuery(className: "Aircrafts")
        let currentUser = PFUser.currentUser()
        query.whereKey("User", equalTo: currentUser!)
        query.whereKey("CurrentAirplane", equalTo: 1)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil{
                //there was no error in the fetch
                if let returnedobjects = objects {
                    for object in returnedobjects{
                        self.currentAirplane = object["Type"] as! String
                        self.currentAirplaneReg = object["Registration"] as! String
                    }
                }
            }
        }
        
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        CLLocationManager().requestAlwaysAuthorization()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    Location delegate methods
    func printTimestamp() {
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .NoStyle , timeStyle: .ShortStyle)
        print(timestamp)
    }
    */
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let regionToZoom = MKCoordinateRegionMake(manager.location!.coordinate, MKCoordinateSpanMake(0.005, 0.005))
        mapView.setRegion(regionToZoom, animated: true)
        let speed = locationManager.location!.speed
        myLocationView.text = String(format: "Current speed: %.0f km/h", speed * 3.6)
        let altitude = round(locationManager.location!.altitude)
        myAltitude.text = String(format:"Current altitude: %.0f m", altitude)
        let latitude = locationManager.location!.coordinate.latitude
        let longitude = locationManager.location!.coordinate.longitude
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        //groundAltitude.text = String(format: "%.0f", location.altitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // City
            if placeMark != nil{
                if let city = placeMark.addressDictionary!["City"] as? String {
                    if let country = placeMark.addressDictionary!["Country"] as? String {
                        self.myLongitude.text = "\(city), \(country)"
                    }
                }
            }
            
        })
        
        var timestamp = ""
        if speed * 3.6 > 11{
            if departureSwitch == 0{
                takeOffTime = NSDate()
                timestamp = NSDateFormatter.localizedStringFromDate(takeOffTime, dateStyle: .NoStyle , timeStyle: .ShortStyle)
                myLatitude.text = "Departed at: \(timestamp)"
                if let toc = self.myLongitude.text{
                    takeOffCity = toc
                    takeOffLatitude = latitude
                    takeOffLongitude = longitude
                }
                departureSwitch = 1
                atLeastOneTime = 1
            }
        }
        else{
            if departureSwitch == 1{
                //let timestamp1 = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .NoStyle , timeStyle: .ShortStyle)
                //minutul cand a aterizat
                //landTime.text = timestamp1
                let inAirTime = String(format: "%d", minutesBetween(takeOffTime, endDate: NSDate()))
                //landTime.text = inAirTime
                departureSwitch = 0
                if minutesBetween(takeOffTime, endDate: NSDate()) >= 1{
                    let formatter = NSDateFormatter()
                    formatter.timeStyle = NSDateFormatterStyle.MediumStyle
                    formatter.dateStyle = NSDateFormatterStyle.NoStyle

                    let flight = PFObject(className: "Flight")
                    
                    flight["landingLatitude"] = latitude
                    flight["landingLongitude"] = longitude
                    flight["takeOffLatitude"] = takeOffLatitude
                    flight["takeOffLongitude"] = takeOffLongitude
                    flight["registration"] = "kmkm"
                    flight["airplane"] = currentAirplane
                    flight["takeOff"] = formatter.stringFromDate(takeOffTime)
                    flight["landing"] = formatter.stringFromDate(NSDate())
                    flight["inAirTime"] = inAirTime
                    flight["user"] = PFUser.currentUser()
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd-MM-YYYY"
                    let dateString = dateFormatter.stringFromDate(NSDate())

                    
                    flight["date"] = dateString
                    flight["takeOffCity"] = takeOffCity
                    flight["landingCity"] = self.myLongitude.text
                    
                    flight.saveInBackgroundWithBlock { (success, error) -> Void in
                        if success {
                               print("success")
                        }
                        else{
                            print(error)
                        }
                    }
                }

            }
        }
        /*let formatter = NSDateFormatter()
        
        formatter.timeStyle = NSDateFormatterStyle.MediumStyle
        formatter.dateStyle = NSDateFormatterStyle.NoStyle
        print(formatter.stringFromDate(NSDate()))
        */
       
        if atLeastOneTime == 1 {
            let currentTime = NSDate()
            //var airTime = currentTime - takeOffTime
            inAirTime.text = String(format:"In air time: %d min", minutesBetween(takeOffTime, endDate: currentTime))
        }

        
    }
    
    
    func minutesBetween(startDate: NSDate, endDate: NSDate) -> Int
    {
        let calendar = NSCalendar.currentCalendar()
        
        let components = calendar.components([.Minute], fromDate: startDate, toDate: endDate, options: [])
        
        return components.minute
    }



    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors: \(error.localizedDescription)")
    }



}
