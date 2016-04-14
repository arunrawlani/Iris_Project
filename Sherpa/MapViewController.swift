//
//  MapViewController.swift
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON


class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var articlework = [ArticleWork]() //loads the article from the Artwork.swift file to visualize on the map
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
                
                self.articlework.append(pinAnnotation)
                self.mapView.addAnnotation(pinAnnotation)
                
            }
           print(self.articlework.count)
        }
        
        for annotation in self.articlework{
            self.mapView.addAnnotation(annotation)
        }
        
        super.viewDidLoad()
        mapView.delegate = self
        
        // set initial location in Montreal
        let initialLocation = CLLocation(latitude: 45.5087, longitude: -73.554)
        
        centerMapOnLocation(initialLocation)
        
        let button   = UIButton(type: UIButtonType.Custom) as UIButton
        button.frame = CGRectMake(100, 100, 150, 50)
        button.addTarget(self, action: "politicsAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button.backgroundColor = UIColor.clearColor()
        button.center = CGPointMake(140.0, 580.0);// for bottomright
        button.setImage((UIImage (named: "politicsIcon.png")), forState: .Normal)
        
        let button2   = UIButton(type: UIButtonType.Custom) as UIButton
        button2.frame = CGRectMake(100, 100, 100, 50)
        button2.addTarget(self, action: "scienceAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button2.center = CGPointMake(250.0, 580.0);// for bottomright
        button2.setImage((UIImage (named: "scienceIcon.png")), forState: .Normal)
        
        let button3   = UIButton(type: UIButtonType.Custom) as UIButton
        button3.frame = CGRectMake(100, 100, 100, 50)
        button3.addTarget(self, action: "entertainmentAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button3.center = CGPointMake(340.0, 580.0);// for bottomright
        button3.setImage((UIImage (named: "entertainmentIcon.png")), forState: .Normal)
        
        let button4   = UIButton(type: UIButtonType.Custom) as UIButton
        button4.frame = CGRectMake(100, 100, 100, 50)
        button4.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button4.backgroundColor = UIColor.clearColor()
        button4.center = CGPointMake(40.0, 580.0);// for bottomright
        button4.setImage((UIImage (named: "generalIcon.png")), forState: .Normal)
        
        self.view.addSubview(button)
        self.view.addSubview(button2)
        self.view.addSubview(button3)
        self.view.addSubview(button4)
    }
    
    //ACTION: Action for the technology
    func buttonAction(sender:UIButton!)
    {
        let annotationsToRemove = self.mapView.annotations
        self.mapView.removeAnnotations( annotationsToRemove )
        
        Alamofire.request(.GET, "https://nsapp.herokuapp.com/articles", encoding: .JSON).responseJSON { (req, res, json) -> Void in
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
                
                self.articlework.append(pinAnnotation)
                self.mapView.addAnnotation(pinAnnotation)
                
            }
            print(self.articlework.count)
        }
        
        
    }
    
    func politicsAction(sender:UIButton!)
    {
        let annotationsToRemove = self.mapView.annotations
        self.mapView.removeAnnotations( annotationsToRemove )
        
        Alamofire.request(.GET, "https://nsapp.herokuapp.com/search?q=brussels", encoding: .JSON).responseJSON { (req, res, json) -> Void in
            self.mapJSON = JSON(json.value!)
            for (key, subJson):(String,JSON) in self.mapJSON{
                
                let lat = subJson["coords","lat"].doubleValue
                let long = subJson["coords","long"].doubleValue
                let summary = subJson["summary"].string!
                let title = subJson["title"].string!
                let view_count = "Views: "+String(subJson["view_count"].int!)
                let url = subJson["link"].string!
                let imagName = "politicsPin.png"
                let pinAnnotation = ArticleWork(title: title, summary: summary, url: url, view_count: view_count, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), imagName: imagName)
                
                self.articlework.append(pinAnnotation)
                self.mapView.addAnnotation(pinAnnotation)
                
            }
            print(self.articlework.count)
        }
        
        
    }
    
    func entertainmentAction(sender:UIButton!)
    {
        let annotationsToRemove = self.mapView.annotations
        self.mapView.removeAnnotations( annotationsToRemove )
        
        Alamofire.request(.GET, "https://nsapp.herokuapp.com/search?q=facebook+buried", encoding: .JSON).responseJSON { (req, res, json) -> Void in
            self.mapJSON = JSON(json.value!)
            for (key, subJson):(String,JSON) in self.mapJSON{
                
                let lat = subJson["coords","lat"].doubleValue
                let long = subJson["coords","long"].doubleValue
                let summary = subJson["summary"].string!
                let title = subJson["title"].string!
                let view_count = "Views: "+String(subJson["view_count"].int!)
                let url = subJson["link"].string!
                let imagName = "entertainmentPin.png"
                let pinAnnotation = ArticleWork(title: title, summary: summary, url: url, view_count: view_count, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), imagName: imagName)
                
                self.articlework.append(pinAnnotation)
                self.mapView.addAnnotation(pinAnnotation)
                
            }
            print(self.articlework.count)
        }
        
        
    }
    
    func scienceAction(sender:UIButton!)
    {
        let annotationsToRemove = self.mapView.annotations
        self.mapView.removeAnnotations( annotationsToRemove )
        
        Alamofire.request(.GET, "https://nsapp.herokuapp.com/search?q=artificial+intelligence", encoding: .JSON).responseJSON { (req, res, json) -> Void in
            self.mapJSON = JSON(json.value!)
            for (key, subJson):(String,JSON) in self.mapJSON{
                
                let lat = subJson["coords","lat"].doubleValue
                let long = subJson["coords","long"].doubleValue
                let summary = subJson["summary"].string!
                let title = subJson["title"].string!
                let view_count = "Views: "+String(subJson["view_count"].int!)
                let url = subJson["link"].string!
                let imagName = "sciencePin.png"
                let pinAnnotation = ArticleWork(title: title, summary: summary, url: url, view_count: view_count, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), imagName: imagName)
                
                self.articlework.append(pinAnnotation)
                self.mapView.addAnnotation(pinAnnotation)
                
            }
            print(self.articlework.count)
        }
        
        
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
            let customannotation = annotation as? ArticleWork
            annotationView!.image = UIImage(named: customannotation!.imagName)
            annotationView!.rightCalloutAccessoryView = detailButton
        }
        else
        {
            annotationView!.annotation = annotation
        }
        self.addBounceAnimationToView(annotationView!)
        return annotationView
    }

    
    //ANIMATION: To add bounce animation to pins
    func addBounceAnimationToView(view: UIView)
    {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale") as CAKeyframeAnimation
        bounceAnimation.values = [ 0.03, 1.6, 0.7, 1.2, 1]
        bounceAnimation.duration = 2.5
        
        let timingFunctions = NSMutableArray(capacity: bounceAnimation.values!.count)
        
        for var i = 0; i < bounceAnimation.values!.count; i++ {
            timingFunctions.addObject(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        }
        bounceAnimation.timingFunctions = timingFunctions as NSArray as? [CAMediaTimingFunction]
        bounceAnimation.removedOnCompletion = false
        
        view.layer.addAnimation(bounceAnimation, forKey: "bounce")
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl) {
            let pin = view.annotation as! ArticleWork
            let placeName = pin.title
            let placeInfo = pin.summary
            let placeurl = pin.url
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.Left
            
            let messageText = NSMutableAttributedString(
                string: placeInfo,
                attributes: [
                    NSParagraphStyleAttributeName: paragraphStyle,
                    NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1),
                    NSForegroundColorAttributeName : UIColor.blackColor()
                ]
            )
            
            let ac = UIAlertController(title: placeName!, message: placeInfo, preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Go to Article", style: .Cancel) { (action) in
                let urlstored = NSURL (string: placeurl);
                if UIApplication.sharedApplication().canOpenURL(urlstored!) {
                    UIApplication.sharedApplication().openURL(urlstored!)
                }
            }
            ac.addAction(cancelAction)
            ac.setValue(messageText, forKey: "attributedMessage")
            ac.addAction(UIAlertAction(title: "Dismiss", style: .Destructive, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer()
        }
        
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.lineWidth = 3.0
        renderer.alpha = 0.5
        renderer.strokeColor = UIColor.blueColor()
        
        return renderer
    }
}

