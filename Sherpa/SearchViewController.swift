//
//  SearchViewController.swift
//  Iris
//
//  Created by Arun Rawlani on 3/19/16.
//  Copyright © 2016 Arun Rawlani. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    

    @IBOutlet weak var recentSearchesTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchActive : Bool = false
    var searchURL: String = ""
    var searchJSON: JSON = []
    let recentSearches: [String] = ["Andi is a cocksucker", "Andi is a chutiya", "Andi sucks Abdullah"];
    let url = "https://nsapp.herokuapp.com/search?keyword="
    
    override func viewDidLoad() {
        
        searchBar.delegate = self;
        
        //Sets a gesture recognizer to dimiss keyboard when screen is clicked
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        
        if segue.identifier == "searchResults" {
            let destinationVC = segue.destinationViewController as! SearchResultsViewController
            destinationVC.searchURL = self.searchURL
            destinationVC.searchJSON = self.searchJSON
        }
    }
    
    //DELEGATE UISEARCHBAR: Delegate methods for the search bar controller
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        self.searchBar.endEditing(true)
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchURL = url + searchBar.text!.lowercaseString
        Alamofire.request(.GET, self.searchURL, encoding: .JSON).responseJSON { (req, res, json) -> Void in
            self.searchJSON = JSON(json.value!)
            //print(self.searchJSON)
            print("Here")
        }
        performSegueWithIdentifier("searchResults", sender: self)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        //if we are updating user's recent searches array
    }
    
    //HELPER: Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //TABLEVIEW PROTOCOL METHODS
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearches.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customcell", forIndexPath: indexPath) as! RecentSearchCell
        let strTitle : NSString = recentSearches[indexPath.row] as NSString
        cell.titleLabel.text = strTitle as String;
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
}
