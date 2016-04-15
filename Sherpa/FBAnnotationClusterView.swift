//
//  FBAnnotationClusterView.swift
//  Iris
//
//  Created by Arun Rawlani on 4/14/16.
//  Copyright © 2016 Arun Rawlani. All rights reserved.
//

import Foundation
import MapKit

class FBAnnotationClusterView : MKAnnotationView {
    
    var count = 0
    
    var fontSize:CGFloat = 12
    
    var clusterSize:ClusterSize = .Medium
    
    var countLabel:UILabel? = nil
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?){
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        let cluster:FBAnnotationCluster = annotation as! FBAnnotationCluster
        count = cluster.annotations.count
        
        // change the size of the cluster image based on number of stories
        switch count {
        case 0...5:
            fontSize = 12
            clusterSize = .Small
        case 6...15:
            fontSize = 13
            clusterSize = .Medium
        default:
            fontSize = 14
            clusterSize = .Large
        }
        backgroundColor = UIColor.clearColor()
        setupLabel()
        setTheCount(count)
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupLabel(){
        countLabel = UILabel(frame: bounds)
        if let countLabel = countLabel {
            countLabel.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            countLabel.textAlignment = .Center
            countLabel.backgroundColor = UIColor.clearColor()
            countLabel.textColor = UIColor.whiteColor()
            countLabel.adjustsFontSizeToFitWidth = true
            countLabel.minimumScaleFactor = 2
            countLabel.numberOfLines = 1
            countLabel.font = UIFont.boldSystemFontOfSize(fontSize)
            countLabel.baselineAdjustment = .AlignCenters
            addSubview(countLabel)
        }
    }
    
    func setTheCount(localCount:Int){
        count = localCount
        countLabel?.text = "\(localCount)"
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        let brandingColor = UIColor.blackColor()
        image = StyleKit.imageOfCluster(clusterSize: clusterSize, color: brandingColor)
        
        countLabel?.frame = self.bounds
        centerOffset = CGPointZero
    }
    
}
