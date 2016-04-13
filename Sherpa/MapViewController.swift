//
//  MapViewController.swift
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON


class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var artworks = [Artwork]() //loads the art work from the Artwork.swift file to visualize on the map
    var mapJSON: JSON = []
    let url = "https://nsapp.herokuapp.com/articles"
    
    
    override func viewDidLoad() { //Implements the viewDidLoad for basic view setup
        /*Getting mapJSON from Database */
        Alamofire.request(.GET, self.url, encoding: .JSON).responseJSON { (req, res, json) -> Void in
            self.mapJSON = JSON(json.value!)
            for (key, subJson):(String,JSON) in self.mapJSON{
                
                let lat = subJson["coords","lat"].doubleValue
                let long = subJson["coords","long"].doubleValue
                let summary = subJson["summary"].string!
                let title = subJson["title"].string!
                let view_count = "Views: "+String(subJson["view_count"].int!)
                let url = subJson["link"].string!
                let imagName = "expandShadow.png"
                let pinAnnotation = ArticleWork(title: title, summary: summary, url: url, view_count: view_count, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), imagName: imagName)
                
                self.mapView.addAnnotation(pinAnnotation)
                
            }
            
        }
        
        super.viewDidLoad()
        mapView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        let articlework = ArticleWork(title: "King David Kalakaua",
            summary: "This is Spartaaaaaa",
            url: "Sculpture", view_count: "View: 233",
            coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661), imagName: "expandShadow.png")
        
        mapView.addAnnotation(articlework)
        
        // set initial location in Montreal
        let initialLocation = CLLocation(latitude: 45.5087, longitude: -73.554)
        
        centerMapOnLocation(initialLocation)
        //loadInitialData()
        //mapView.addAnnotations(artworks)
        
    }
    
    // MARK: - location manager to authorize user location for Maps app
    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
//        for (key, subJson):(String,JSON) in mapJSON{
//            
//            let lat = subJson["coords","lat"].doubleValue
//            let long = subJson["coords","long"].doubleValue
//            
//            let pinAnnotation = MKPointAnnotation()
//            pinAnnotation.coordinate = CLLocationCoordinate2DMake(Double(lat), Double(long))
//            pinAnnotation.title = subJson["title"].string!
//            let viewString = "Views: "+String(subJson["view_count"].int!)
//            pinAnnotation.subtitle = viewString
//            
//            self.mapView.addAnnotation(pinAnnotation)
//            
//        }
    }
    
    override func viewDidAppear(animated: Bool) {// Implements the method to check authorization status
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    
    let regionRadius: CLLocationDistance = 100000 //specifies the region for which map is shown
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 50.0, regionRadius * 50.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
}

extension MapViewController: MKMapViewDelegate {
    
    // Uses annotation and creates a view -check.
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        
        if !(annotation is ArticleWork) {
            return nil
        }
        
        let detailButton: UIButton = UIButton(type: UIButtonType.DetailDisclosure)
        
        // Reuse the annotation if possible
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        
        if annotationView == nil
        {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            annotationView!.canShowCallout = true
            annotationView!.image = UIImage(named: "expandShadow.png")
            annotationView!.rightCalloutAccessoryView = detailButton
        }
        else
        {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl) {
            let capital = view.annotation as! ArticleWork
            let placeName = capital.title
            let placeInfo = capital.summary
            
            let ac = UIAlertController(title: placeName!, message: placeInfo, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
    }
}

