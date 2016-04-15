//
//  FBAnnotationCluster.swift
//  Iris
//
//  Created by Arun Rawlani on 4/14/16.
//  Copyright © 2016 Arun Rawlani. All rights reserved.
//

import Foundation
import MapKit

public class FBAnnotationCluster : NSObject {
    
    public var coordinate = CLLocationCoordinate2D(latitude: 39.208407, longitude: -76.799555)
    
    public var title:String? = "cluster"
    public var subtitle:String? = nil
    
    public var annotations:[MKAnnotation] = []
    
}

extension FBAnnotationCluster : MKAnnotation {
    
    
    
}
