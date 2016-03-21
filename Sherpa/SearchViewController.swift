//
//  SearchViewController.swift
//  Iris
//
//  Created by Arun Rawlani on 3/19/16.
//  Copyright © 2016 Arun Rawlani. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController{
    
    //MARK:Properties
    let searchController = UISearchController(searchResultsController: nil)
    var recentSearch = [String]()
    var filteredResults = [String]()
    
    //MARK:Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup the Search Controller
        searchController.searchResultsUpdater = self;
        searchController.searchBar.delegate = self;
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["All", "Social", "Technology", "Disaster"]
        tableView.tableHeaderView = searchController.searchBar
        
        recentSearch = ["Donald Trump", "Bernie", "US Presidential Election", "Friends", "The Office", "World Cup", "Cricket", "Oculus VR"]
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredResults.count
        }
        return recentSearch.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let result:String
        if searchController.active && searchController.searchBar.text != "" {
            result = filteredResults[indexPath.row]
        } else {
            result = recentSearch[indexPath.row]
        }
        cell.textLabel!.text = result
        return cell
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredResults = recentSearch.filter({(result: String) -> Bool in
            let categoryMatch = (scope == "All")
            return categoryMatch && result.lowercaseString.containsString(searchText.lowercaseString)
        })
        tableView.reloadData()
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension SearchViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}
