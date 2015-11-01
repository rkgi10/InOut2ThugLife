//
//  HospitalsTableViewController.swift
//  Inout2ThugLife
//
//  Created by Rohit Gurnani on 01/11/15.
//  Copyright © 2015 Rohit Gurnani. All rights reserved.
//

import UIKit

class HospitalsTableViewController: UITableViewController {
    
    let hospitals = HospitalData

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let locationManager = CLLocationManager()
    var placesClient: GMSPlacesClient?
    let apiServerKey = "AIzaSyAf1Jmdaf2ulU8xxP6-22U5-wYaebtSKtw"
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var currentLocationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationSetup()
        placesClient = GMSPlacesClient()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationSetup()
    {
        print("fetching location")
        placesClient?.currentPlaceWithCallback({ (placeLikelihoodList: GMSPlaceLikelihoodList?, error: NSError?) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            
            
            if let placeLicklihoodList = placeLikelihoodList {
                let place = placeLicklihoodList.likelihoods.first?.place
                if let place = place {
                    self.currentLocationLabel.text = place.name
                    print(place.name)
                    
                    
                    //                    self.button2.titleLabel?.text = place.formattedAddress.
                    //
                    //                    self.button2.titleLabel!.text = "\n".join(place.formattedAddress.componentsSeparatedByString(", "))
                }
            }
        })
        indicatorActivity()

    }
    
    func indicatorActivity ()
    {
        
        CozyLoadingActivity.showWithDelay("Looking up", sender: self, disableUI: true, seconds: 3.0)
        let delay = 4.5 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            CozyLoadingActivity.hide(success: true, animated: true)
        }
        
    }
    
    @IBAction func field1tapped(sender: AnyObject) {
                placeAutocomplete()
    }
    
    func placeAutocomplete() {
        let filter = GMSAutocompleteFilter()
        filter.type = GMSPlacesAutocompleteTypeFilter.Establishment
        placesClient?.autocompleteQuery("Hospital", bounds: nil, filter: filter, callback: { (results, error: NSError?) -> Void in
            if let error = error {
                print("Autocomplete error \(error)")
            }
            
            for result in results! {
                if let result = result as? GMSAutocompletePrediction {
                    print("Result \(result.attributedFullText) with placeID \(result.placeID)")
                }
            }
        })
    }
    
//    func fetchPlacesNearCoordinate(coordinate: CLLocationCoordinate2D, radius: Double, name : String){
//        var urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=\(apiServerKey)&location=\(coordinate.latitude),\(coordinate.longitude)&radius=\(radius)&rankby=prominence&sensor=true"
//        urlString += "&name=\(name)"
//        
//        urlString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
//        print(urlString)
//        if placesTask.taskIdentifier > 0 && placesTask.state == .Running {
//            placesTask.cancel()
//            
//        }
//        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
//        placesTask = session.dataTaskWithURL(NSURL(string: urlString)!) {data, response, error in
//            println("inside.")
//            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//            if let json = NSJSONSerialization.JSONObjectWithData(data, options:nil, error:nil) as? NSDictionary {
//                if let results = json["results"] as? NSArray {
//                    for rawPlace:AnyObject in results {
//                        println(rawPlace)
//                        self.results.append(rawPlace as! String)
//                    }
//                }
//            }
//            self.placesTask.resume()
//        }
//    }

    
    
    
    
    
    
    
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hospitals.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! HospitalsCellViewControllerTableViewCell
        
        cell.hospital = hospitals[indexPath.row]

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
