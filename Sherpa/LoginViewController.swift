//
//  LoginViewController.swift
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Parse
import ParseUI
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
  
    @IBOutlet weak var usernameTF: UITextField! //gets the username
    @IBOutlet weak var passwordTF: UITextField! //gets the password
    var window: UIWindow?
    
    var currentUser: PFUser? //forms object for the current user
    var startViewController: UIViewController?
    
  
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView //creates activity indicator that will activate when log in is pressed
    
  
  override func viewDidLoad() {
    super.viewDidLoad() //loads the view
    
    //Changing tint color
    let color: UIColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 100.0)
    self.usernameTF.tintColor = color
    self.passwordTF.tintColor = color
    
    
    self.actInd.center = self.view.center
    
    self.actInd.hidesWhenStopped = true
    
    self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
    
    view.addSubview(self.actInd) //adds the activity indicator to the subview
    
    //this causes our activity indicator to be in the center of the view with colour White
    
    if currentUser != nil { //If user is logged in, switch to the main screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        startViewController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as? UIViewController
    } else {
        print("No user is logged in. \n Login or signup")
    }
    
    
  }
    
    //MARK:Actions
    
    @IBAction func loginAction(sender: AnyObject) {
        
        let username = self.usernameTF.text
        let password = self.passwordTF.text
        
        
        if (username!.utf16.count < 3 || password!.utf16.count < 3){ //checks if username and password is valid
            
            let alert = UIAlertController(title: "Invalid", message: "Username and Password are too short.", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                //...
            }
            alert.addAction(OKAction)
            
            self.presentViewController(alert, animated: true, completion: nil)

          }
        
        else //logs in
        {
            self.actInd.startAnimating()
            
            let url = "https://nsapp.herokuapp.com/login"
            Alamofire.request(.POST, url, parameters: ["email":usernameTF.text!, "password":passwordTF.text!], encoding: .JSON).responseJSON { (req, res, json) -> Void in
                let message = JSON(json.value!)["message"]
                if (message == "login success"){
                    let alert = UIAlertController(title: "Success", message: "Logged In.", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                    }
                    alert.addAction(OKAction)
                    self.actInd.stopAnimating()
                    self.performSegueWithIdentifier("testSegue", sender: nil)
                }
                else if (message == "user not found"){
                    let alert = UIAlertController(title: "Error", message: "User not found. Enter valid parameters.", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                        //creates the alert view if invalid login parameters are inputted
                    }
                    alert.addAction(OKAction)
                    self.actInd.stopAnimating()
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else {
                    let alert = UIAlertController(title: "Error", message: "Credentials are incorrect. Enter correct parameters.", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                        //creates the alert view if invalid login parameters are inputted
                    }
                    alert.addAction(OKAction)
                    self.actInd.stopAnimating()
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

