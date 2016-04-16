//
//  SearchResultsViewController.swift
//  Iris
//
//  Created by Arun Rawlani on 3/19/16.
//  Copyright © 2016 Arun Rawlani. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class SearchResultsViewController: UIViewController, UITableViewDelegate , UITableViewDataSource, article{
    
    let yourJsonFormat: String = "JSONFile" // set text JSONFile : json data from file
    var searchURL: String?
    var searchJSON: JSON = []
    var arrDict :NSMutableArray=[]
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var expandButton: UIButton!
    
    //ADDING THE DELAY FUNCTION USED IN SWIFT SPINNER
    //ADDING SWIFT SPINNER
    func delay(seconds seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }
    
    func demoSpinner() {
        
        SwiftSpinner.showWithDelay(2.0, title: "It's taking longer than expected")
        
        delay(seconds: 0.0, completion: {
            SwiftSpinner.show("Searching for \n Articles...")
        })
        
        delay(seconds: 2.0, completion: { //2.0
            SwiftSpinner.show("Fetching the \n Articles..")
        })
        
        delay(seconds: 5.0, completion: { //4.0
            SwiftSpinner.show("Extracting the Previews...")
        })
        
        delay(seconds: 8.0, completion: { //5.5
            SwiftSpinner.setTitleFont(nil)
            SwiftSpinner.show("Displaying \nArticles", animated: false)
        })
        
        delay(seconds: 9.0, completion: { //6.0
            SwiftSpinner.hide()
            self.tableview.reloadData()
        })
        
    }
    
    //END OF SWIFT SPINNER
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(searchURL!)
        self.demoSpinner()
        
        Alamofire.request(.GET, self.searchURL!, encoding: .JSON).responseJSON { (req, res, json) -> Void in
            self.searchJSON = JSON(json.value!)
            self.tableview.reloadData();
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        tableview.allowsMultipleSelection = true

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableview.reloadData();
    }
    
    
    var titleLabel: String = ""
    var summary: String = ""
    var view_count: String = ""
    var imaglink: String = ""
    var articlelink: String = ""
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToReserveTour"{
            let reserveVC: ReserveViewController = segue.destinationViewController as! ReserveViewController
            reserveVC.tourName = titleLabel
            print("TITLE: " + titleLabel)
            print("SUMMARY:" + summary)
            print("VIEW_COUNT:" + view_count)
            reserveVC.tourSum = summary
            reserveVC.tourCost = view_count
            reserveVC.imaglink = imaglink
            reserveVC.articlelink = articlelink
        }
        
    }
    
    func expandArticle(titleLabel: String, summary: String, view_count: String, imaglink: String, articlelink: String) {
        self.titleLabel = titleLabel
        self.summary = summary
        self.view_count = view_count
        self.imaglink = imaglink
        self.articlelink = articlelink
        performSegueWithIdentifier("goToReserveTour", sender: self)
    }
    
    
    
    
    //JSON PARSING: From URL
    func jsonParsingFromURL () {
        let url = NSURL(string: "")
        let request = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            self.startParsing(data!)
        }
    }
    
    //JSON PARSING: From File
    func jsonParsingFromFile()
    {
        let path: NSString = NSBundle.mainBundle().pathForResource("Articles", ofType: "json")!
        let data : NSData = try! NSData(contentsOfFile: path as String, options: NSDataReadingOptions.DataReadingMapped)
        
        self.startParsing(data)
    }
    
    func startParsing(data :NSData)
    {
        let dict: NSDictionary!=(try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
        
        for var i = 0 ; i < (dict.valueForKey("articles") as! NSArray).count ; i++
        {
            arrDict.addObject((dict.valueForKey("articles") as! NSArray) .objectAtIndex(i))
        }
        tableview.reloadData()
    }

    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows where selectedIndexPaths.contains(indexPath) {
            return 220.0 // Expanded height
        }
        
        return 78.0 // Normal height
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchJSON.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SearchResultCell
        cell.delegate = self
        cell.backgroundColor = UIColor.clearColor()
        let strTitle : NSString=self.searchJSON[indexPath.row]["title"].string!
        let strSummary : NSString=self.searchJSON[indexPath.row]["summary"].string!
        let strViews: NSString=String(self.searchJSON[indexPath.row]["view_count"])
        let strLink: NSString=self.searchJSON[indexPath.row]["link"].string!
        
        cell.titleLabel.text = strTitle as String
        cell.summaryLabel.text = strSummary as String
        cell.viewLabel.text = strViews as String
        cell.articlelink = strLink as String
        cell.imaglink = self.searchJSON[indexPath.row]["image"].string!
        return cell;
    }
    
    func someAction() {
        self.performSegueWithIdentifier("goToReserveTour", sender: self)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
        updateTableView()
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        updateTableView()
    }
    
   private func updateTableView() {
        tableview.beginUpdates()
        tableview.endUpdates()
    }
    
}