//
//  ArticleWork.swift
//  Iris
//
//  Created by Arun Rawlani on 4/12/16.
//  Copyright © 2016 Arun Rawlani. All rights reserved.
//

import Foundation
import MapKit
import Alamofire
import SwiftyJSON

class ArticleWork: NSObject, MKAnnotation {
    let title: String?
    let summary: String
    let url: String
   // let discipline: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, summary: String, url: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.summary = summary
       // self.discipline = discipline
        self.url = url
        self.coordinate = coordinate
        
        super.init()
        
    }
    
    var subtitle: String? {
        return summary
    }
    
    class func fromJSON(json: JSON) -> ArticleWork? {
        // 1
        var title: String
        if let titleOrNil = json[16].string {
            title = titleOrNil
        } else {
            title = ""
        }
        let summary = json[12].string
        let url = json[15].string
        
        // 2
        let latitude = Double(json["coords"]["lat"].string!)
        let longitude = (json[19].string! as NSString).doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude)
        
        // 3
        return ArticleWork(title: title, summary: summary!, url: url!, coordinate: coordinate)
    }
    
    // pinColor for disciplines: Sculpture, Plaque, Mural, Monument, other
//    func pinColor() -> MKPinAnnotationColor  {
//        switch discipline {
//        case "Sculpture", "Plaque":
//            return .Green
//        case "Mural", "Monument":
//            return .Green
//        default:
//            return .Green
//        }
//    }
    
    // annotation callout info button opens this mapItem in Maps app
//    func mapItem() -> MKMapItem {
//        let addressDictionary = [String(kABPersonAddressStreetKey): subtitle as! AnyObject]
//        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
//        
//        let mapItem = MKMapItem(placemark: placemark)
//        mapItem.name = title
//        
//        return mapItem
//    }
}
