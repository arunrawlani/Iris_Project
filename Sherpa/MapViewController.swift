//
//  MapViewController.swift
//

import UIKit
import MapKit



class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var artworks = [Artwork]() //loads the art work from the Artwork.swift file to visualize on the map
    
    override func viewDidLoad() { //Implements the viewDidLoad for basic view setup
        super.viewDidLoad()
        mapView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: -9.808953, longitude: -37.615958)
        
        centerMapOnLocation(initialLocation)
        loadInitialData()
        mapView.addAnnotations(artworks)
        
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
    
    override func viewDidAppear(animated: Bool) {// Implements the method to check authorization status
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let regionRadius: CLLocationDistance = 100000 //specifies the region for which map is shown
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 50.0, regionRadius * 50.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func loadInitialData() {
        //loads initial data from the hosted json file -check.
        let fileName = NSBundle.mainBundle().pathForResource("PublicArt", ofType: "json"); //selects file to get the information
        var readError : NSError?
        var data: NSData = try! NSData(contentsOfFile: fileName!, options: NSDataReadingOptions(rawValue: 0))
        
        // Throws an error if JSON object is not as formatted -check.
        var error: NSError?
        let jsonObject: AnyObject!
        do {
            jsonObject = try NSJSONSerialization.JSONObjectWithData(data,
                        options: NSJSONReadingOptions(rawValue: 0))
        } catch var error1 as NSError {
            error = error1
            jsonObject = nil
        }
        
        // Parses the JSON object to get it mapped
        if let jsonObject = jsonObject as? [String: AnyObject] where error == nil,
        
            let jsonData = JSONValue.fromObject(jsonObject)?["data"]?.array {
                for artworkJSON in jsonData {
                    if let artworkJSON = artworkJSON.array,
                    
                        artwork = Artwork.fromJSON(artworkJSON) {
                            artworks.append(artwork)
                    }
                }
        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    // Uses annotation and creates a view -check.
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView! {
        if let annotation = annotation as? Artwork {
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
                view.pinColor = annotation.pinColor()
                view.image = UIImage(named: "tree")
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

