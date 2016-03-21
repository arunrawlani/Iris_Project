//
//  SearchResultsViewController.swift
//  Iris
//
//  Created by Arun Rawlani on 3/19/16.
//  Copyright © 2016 Arun Rawlani. All rights reserved.
//

import Foundation

class SearchResultsViewController: UIViewController, UITableViewDelegate , UITableViewDataSource{
    
    let yourJsonFormat: String = "JSONFile" // set text JSONFile : json data from file
    // set text JSONUrl : json data from web url
    
    var arrDict :NSMutableArray=[]
    
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if yourJsonFormat == "JSONFile" {
            jsonParsingFromFile()
        } else {
            //jsonParsingFromURL()
        }
        // Do any additional setup after loading the view, typically from a nib.
        tableview.allowsSelection = false

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
        return 110.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDict.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SearchResultCell
        cell.backgroundColor = UIColor.clearColor()
        let strTitle : NSString=arrDict[indexPath.row] .valueForKey("title") as! NSString
        let strSummary : NSString=arrDict[indexPath.row] .valueForKey("summary") as! NSString
        let strViews: NSString=arrDict[indexPath.row] .valueForKey("viewcount") as! NSString
        cell.titleLabel.text = strTitle as String
        cell.summaryLabel.text = strSummary as String
        cell.viewLabel.text = strViews as String
        
        return cell;
    }
    
}