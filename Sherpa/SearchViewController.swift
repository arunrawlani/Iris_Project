//
//  SearchViewController.swift
//  Iris
//
//  Created by Arun Rawlani on 3/19/16.
//  Copyright © 2016 Arun Rawlani. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
     var searchActive : Bool = false
    
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
        
        delay(seconds: 2.0, completion: {
            SwiftSpinner.show("Fetching the \n Articles..")
        })
        
        delay(seconds: 4.0, completion: {
            SwiftSpinner.show("Extracting Article Preview...")
        })
        
        delay(seconds: 5.0, completion: {
            SwiftSpinner.setTitleFont(nil)
            SwiftSpinner.show("Showing Articles", animated: false)
        })
        
        delay(seconds: 6.0, completion: {
            SwiftSpinner.hide()
        })
        
    }
    
    //END OF SWIFT SPINNER
    
    override func viewDidLoad() {
        searchBar.delegate = self;
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
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
        self.demoSpinner()
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

    
}
