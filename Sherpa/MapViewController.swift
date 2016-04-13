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
    let url = "https://nsapp.herokuapp.com/search?keyword=iphone"
    
    
    override func viewDidLoad() { //Implements the viewDidLoad for basic view setup
        /*Getting mapJSON from Database */
        Alamofire.request(.GET, self.url, encoding: .JSON).responseJSON { (req, res, json) -> Void in
            self.mapJSON = JSON(json.value!)
            print(self.mapJSON)
        }
        
        super.viewDidLoad()
        mapView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        let articlework = ArticleWork(title: "King David Kalakaua",
            summary: "This is Spartaaaaaa",
            url: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        
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
        for (key, subJson):(String,JSON) in mapJSON{
            
            print(subJson["summary"].string!)
            print(subJson["coords","lat"])
            let lat = subJson["coords","lat"].doubleValue
            let long = subJson["coords","long"].doubleValue
            
            let pinAnnotation = MKPointAnnotation()
            pinAnnotation.coordinate = CLLocationCoordinate2DMake(Double(lat), Double(long))
            pinAnnotation.title = subJson["title"].string!
            let viewString = "Views: "+String(subJson["viewcount"].int)
            pinAnnotation.subtitle = viewString
            
            self.mapView.addAnnotation(pinAnnotation)
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {// Implements the method to check authorization status
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    
    let regionRadius: CLLocationDistance = 100000 //specifies the region for which map is shown
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 30.0, regionRadius * 30.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
//    func loadInitialData() {
//        //loads initial data from the hosted json file -check.
//        let fileName = mapJSON //selects file to get the information
//        var readError : NSError?
//        var data: NSData = try! mapJSON!.rawData()
//        
//        // Throws an error if JSON object is not as formatted -check.
//        var error: NSError?
//        let jsonObject: AnyObject!
//        do {
//            jsonObject = try mapJSON?.object
//        } catch var error1 as NSError {
//            error = error1
//            jsonObject = nil
//        }
//        
//        // Parses the JSON object to get it mapped
//        if let jsonObject = jsonObject as? [String: AnyObject] where error == nil,
//        
//            let jsonData = JSONValue.fromObject(jsonObject)?.array {
//                for artworkJSON in mapJSON {
//                    if let artworkJSON = artworkJSON
//                    
//                        artwork = ArticleWork.fromJSON(artworkJSON) {
//                            artworks.append(articlework)
//                    }
//                }
//        }
//    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    // Uses annotation and creates a view -check.
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ArticleWork {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                // Creates the pin on the map view and makes a detail disclosure pop up. -check.
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                //view.pinColor = annotation.pinColor()
                view.image = UIImage(named: "expandButton")
                view.calloutOffset = CGPoint(x: -5, y: 5)
                // view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
            }
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl) {
            let location = view.annotation as! Artwork
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            location.mapItem().openInMapsWithLaunchOptions(launchOptions)
    }
}

