//
//  ToursTableCell.swift
//

import UIKit

protocol tour {
    func goToOverview(tourName: String, imageName: String, costLabel: String)
}

class ToursTableCell: UITableViewCell {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var costLabel: UILabel!
    @IBOutlet var languagesName: UILabel!
    @IBOutlet var TourName: UILabel!
    
    var imageFilename: String = ""
    
    var delegate: tour? = nil
    
    @IBAction func goToOverview(sender: AnyObject) {
        if (delegate != nil) {
            delegate!.goToOverview(TourName.text!, imageName: imageFilename, costLabel: costLabel.text!)
        }
    }
}
