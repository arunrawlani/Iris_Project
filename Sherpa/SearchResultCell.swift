//
//  SearchResultCellViewController.swift
//  Iris
//
//  Created by Arun Rawlani on 3/20/16.
//  Copyright © 2016 Arun Rawlani. All rights reserved.
//

import Foundation
import UIKit

protocol article {
    func expandArticle(titleLabel: String, summary: String, view_count: String, imaglink: String, articlelink:String)
}

class SearchResultCell: UITableViewCell{
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var viewLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    
    var articlelink: String!
    var imaglink:String!
    
    var delegate: article? = nil
    
    @IBAction func expandArticle(sender: AnyObject) {
        if (delegate != nil) {
            delegate!.expandArticle(titleLabel.text!, summary: summaryLabel.text!, view_count: viewLabel.text!, imaglink: imaglink, articlelink: articlelink)
        }
    }
    
    
}
