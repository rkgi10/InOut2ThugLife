//
//  MedicineCheckerTableViewController.swift
//  Inout2ThugLife
//
//  Created by Rohit Gurnani on 31/10/15.
//  Copyright © 2015 Rohit Gurnani. All rights reserved.
//

import UIKit

class MedicineCheckerTableViewController: UITableViewController , UISearchResultsUpdating{
    
    let medicineListData = medicineData
    var filteredMedicines : [Medicine] = []
    var resultSearchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Medicines"
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        definesPresentationContext = true
        
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        
        self.tableView.reloadData()
                // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MedicineCell")
        
        var medicine : Medicine!
        
        if self.resultSearchController.active {
            medicine = filteredMedicines[indexPath.row]
        }
        else
        {
            medicine = medicineListData[indexPath.row]
        }
        cell?.textLabel?.text = medicine.name
        cell?.detailTextLabel?.text = "Rs \((medicine.price)!)"
        return cell!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSearchController.active {
            return self.filteredMedicines.count
        }
        else
        {
            return medicineListData.count
        }
    }
    
    func filterContentforSearchText(searchText : String)
    {
        filteredMedicines = medicineListData.filter({
            (medicine : Medicine) -> Bool in
            let medicineMatch = medicine.name?.rangeOfString(searchText, options : NSStringCompareOptions.CaseInsensitiveSearch)
            
            return medicineMatch != nil
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
                let searchText = searchController.searchBar.text
                filterContentforSearchText(searchText!)
                tableView.reloadData()
        }
    }
    
    
   //    func filterContentForSearchText(searchText : String, scope : String = "All")
//    {
//        self.filteredMedicines = self.medicines.filter({
//            (medicine : Medicine) -> Bool in
//            let categoryMatch = (scope == "All") || (medicine.category == scope)
//            let stringMatch = medicine.name?.rangeOfString(searchText)
//            return (categoryMatch && (stringMatch != nil))
//        })
//    }
    
   
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


