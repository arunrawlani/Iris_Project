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
    var recentSearches: [String] = ["Cool361 Project", "Megan Fox", "Vybihal is best professor"];
    let url = "https://nsapp.herokuapp.com/search?q="
    var i = 0
    override func viewDidLoad() {
        
        searchBar.delegate = self;
        
        //Sets a gesture recognizer to dimiss keyboard when screen is clicked
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
//        Alamofire.request(.GET, "https://nsapp.herokuapp.com/search_history", encoding: .JSON).responseJSON { (req, res, json) -> Void in
//            let recentJSON = JSON(json.value!)
//            self.recentSearches = []
//            for (key, subJson):(String,JSON) in recentJSON{
//                let search = subJson["search_history"]
//                var searchString = ""
//                for (key, subJson): (String, JSON) in search{
//                    print(search)
//                    searchString = searchString + " " + subJson.string!
//                }
//                self.recentSearches.append(searchString)
//            }
//        }
//        self.recentSearchesTable.reloadData()
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
        let searchString = searchBar.text?.lowercaseString
        let processedString = String(searchString!.characters.map {
            $0 == " " ? "+" : $0
            })
        print(processedString)
        self.searchURL = url + processedString
        Alamofire.request(.GET, self.searchURL, encoding: .JSON).responseJSON { (req, res, json) -> Void in
            self.searchJSON = JSON(json.value!)
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
