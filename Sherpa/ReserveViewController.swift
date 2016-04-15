//
//  ReserveViewController.swift
//

import Foundation
import AKPickerView_Swift
import Parse

class ReserveViewController: UIViewController{
    
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewNumLabel: UILabel!
    @IBOutlet weak var articlePicture: UIImageView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var openArticle: UIButton!
    
    @IBOutlet weak var requestButton: UIButton!
    var requestPressedCounter: Int = 1
    
    var cells: NSArray = []
    var languages = ["Mandarin", "Japanese", "Hindi", "Urdu", "Saitama", "Chiba", "Hyogo", "Hokkaido", "Fukuoka", "Shizuoka"]
    var time = ["9:30", "10:30", "11:30", "12:30", "1:30", "2:30", "3:30"]
    
     var tourCost: String = "" //costLabel
     var tourName: String = "" //nameLabel
     var tourSum: String = "" //sumLabel
     var imaglink: String = "" //article image link
     var articlelink: String = "" //article link
    
    
     var tourLang: [String] = [] //pickerView
     var tourTimes: [String] = [] //timePicker
     var reviewsNum: Int = 0 //reviewNumLabel
     var selectedLanguage: String = ""
     var selectedTime: String = ""
     var selectedTour : Tour?
     var createdBy: PFUser?
     var avgRating: Int?
     var mainImage: UIImage?
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
   let transitionManager = TransitionManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sumLabel.text = tourSum
        self.nameLabel.text = tourName;
        self.reviewNumLabel.text = tourCost
        self.selectedLanguage = "None"
        self.selectedTime = "None"
        let articleImageLink = NSURL(string: self.imaglink as String)
        articlePicture.contentMode = .ScaleAspectFill
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            if let data = NSData(contentsOfURL: articleImageLink!) {
                //make sure your image in this url does exist,  otherwise unwrap in a if let check
                dispatch_async(dispatch_get_main_queue(), {
                    self.self.articlePicture.image = UIImage(data: data)
                });
            }
            else{
                print("No image found")
            }
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if let avgRating = avgRating {
            print ("THIS IS \(avgRating)")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (selectedTime == "1"){
            let number = 2*40
            let answer = String(number)
            self.totalLabel.text = answer
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // this gets a reference to the screen that we're about to transition to
        var toViewController = (segue.destinationViewController as! UINavigationController).topViewController as! ReviewViewController
        toViewController.reviewedTour = self.selectedTour
        
        
    }
 
    
    func requestButtonPressed(sender: UIButton) {
            print("Do nothing")
        }
        
    @IBAction func openArticleWithButton(sender: AnyObject) {
        let urlstored = NSURL (string: self.articlelink);
        if UIApplication.sharedApplication().canOpenURL(urlstored!) {
            UIApplication.sharedApplication().openURL(urlstored!)
        }
    }
    }






