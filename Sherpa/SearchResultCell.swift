//
//  SearchResultCellViewController.swift
//  Iris
//
//  Created by Arun Rawlani on 3/20/16.
//  Copyright © 2016 Arun Rawlani. All rights reserved.
//

import Foundation
import UIKit

class SearchResultCell: UITableViewCell{
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var viewLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    var link: String!
    
    @IBAction func expandArticle(sender: AnyObject) {
        print("expandclicked");
        let urlstored = NSURL (string: link);
        print(urlstored)
            if UIApplication.sharedApplication().canOpenURL(urlstored!) {
                UIApplication.sharedApplication().openURL(urlstored!)
            }
    }
    
    
}
