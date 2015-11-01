//
//  MedicineCheckerTableViewController.swift
//  Inout2ThugLife
//
//  Created by Rohit Gurnani on 31/10/15.
//  Copyright © 2015 Rohit Gurnani. All rights reserved.
//

import UIKit
import Foundation

class MedicineCheckerTableViewController: UITableViewController , UISearchResultsUpdating, UINavigationControllerDelegate, UIImagePickerControllerDelegate, TesseractDelegate{
    
    var activityIndicator:UIActivityIndicatorView!
    let medicineListData = medicineData
    var filteredMedicines : [Medicine] = []
    var resultSearchController = UISearchController()
    //var tesseract:Tesseract = Tesseract();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Medicines"
        self.tableView.backgroundColor = UIColor.flatBrownColor()
        
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
    
    func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
        activityIndicator = nil
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
    @IBAction func cameraButtonDeveloped(sender: UIBarButtonItem) {
       takePicOrSelectAPic()
    }
    
    func takePicOrSelectAPic()
    {
        // 2
        let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Photo",
            message: nil, preferredStyle: .ActionSheet)
        
        // 3
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            let cameraButton = UIAlertAction(title: "Take Photo",
                style: .Default) { (alert) -> Void in
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .Camera
                    self.presentViewController(imagePicker,
                        animated: true,
                        completion: nil)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        
        // 4
        let libraryButton = UIAlertAction(title: "Choose Existing",
            style: .Default) { (alert) -> Void in
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .PhotoLibrary
                self.presentViewController(imagePicker,
                    animated: true,
                    completion: nil)
        }
        imagePickerActionSheet.addAction(libraryButton)
        
        // 5
        let cancelButton = UIAlertAction(title: "Cancel",
            style: .Cancel) { (alert) -> Void in
        }
        imagePickerActionSheet.addAction(cancelButton)
        
        // 6
        presentViewController(imagePickerActionSheet, animated: true,
            completion: nil)

    }
    
    func scaleImage(image: UIImage, maxDimension: CGFloat) -> UIImage {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        var scaleFactor: CGFloat
        
        if image.size.width > image.size.height {
            scaleFactor = image.size.height / image.size.width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = image.size.width / image.size.height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        image.drawInRect(CGRectMake(0, 0, scaledSize.width, scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        let scaledImage = scaleImage(selectedPhoto, maxDimension: 640)
        
        addActivityIndicator()
        
        dismissViewControllerAnimated(true, completion: {
            self.performImageRecognition(scaledImage)
        })
    }
    
    func performImageRecognition(image: UIImage) {
        var tesseract:Tesseract = Tesseract(language:"eng+fra");
        //tesseract.language = "eng+ita";
        tesseract.delegate = self;
        //tesseract.characterBoxes = "01234567890";
        tesseract.image = image
        tesseract.recognize();
        
        NSLog("%@", tesseract.recognizedText);
        // 1
        
        resultSearchController.active = true
        resultSearchController.searchBar.text = tesseract.recognizedText
        filterContentforSearchText(tesseract.recognizedText)
        
        //updateSearchResultsForSearchController(resultSearchController)
        // 7
       
        
        // 8
        removeActivityIndicator()
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


