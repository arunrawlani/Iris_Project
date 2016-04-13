//
//  SignViewController.swift
//

import Foundation
import UIKit
import Parse
import Alamofire
import SwiftyJSON


class SignViewController: UIViewController{
    
    var checkState = 0
    let registerurl = "https://nsapp.herokuapp.com/register"

    @IBOutlet weak var firstNameTF: UITextField!
    
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var checkBox: UIButton!
    
 
    @IBAction func checkToggle(sender: UIButton) {
        sender.selected = !sender.selected
    }
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Customizing tint of the text fields
        let color: UIColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 100.0)
        self.firstNameTF.tintColor = color
        self.lastNameTF.tintColor = color
        self.usernameTF.tintColor = color
        self.passwordTF.tintColor = color
        self.emailTF.tintColor = color
        
        self.actInd.center = self.view.center
        
        
        self.actInd.hidesWhenStopped = true
        
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
        
        view.addSubview(self.actInd)
        
        //this causes our activity indicator to be in the center of the view with colour White
    }
    
    //MARK: Actions
    @IBAction func signUpAction(sender: AnyObject) {
        
        let firstName = self.firstNameTF.text
        let lastName = self.lastNameTF.text
        let username = self.usernameTF.text
        let password = self.passwordTF.text
        let email = self.emailTF.text
        let pointsEarned = 0
        let treesPlanted = 0
        
        
        if (firstName!.utf16.count < 1 || lastName!.utf16.count < 1){
            let alert = UIAlertController(title: "Invalid", message: "Enter enter a valid First and Last name.", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                //...
            }
            alert.addAction(OKAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        else if (username!.utf16.count < 3 || password!.utf16.count < 3){
            
            let alert = UIAlertController(title: "Invalid", message: "Username and Password are too short.", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                //...
            }
            alert.addAction(OKAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if (email!.utf16.count < 10) {
            
            let alert = UIAlertController(title: "Invalid", message: "Please enter a valid email", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                //...
            }
            alert.addAction(OKAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        else if (checkBox.selected == false)
        {
                let alert = UIAlertController(title: "Invalid", message: "Check the box in order to proceed", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                    //...
                }
                alert.addAction(OKAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
        else{
            
            self.actInd.startAnimating()
            
//            let newUser = PFUser()
//            
//            newUser["firstName"] = firstName
//            newUser["lastName"] = lastName
//            newUser.username = username
//            newUser.password = password
//            newUser.email = email
//            newUser["pointsEarned"] = pointsEarned
//            newUser["treesPlanted"] = treesPlanted
//            
//            newUser.signUpInBackgroundWithBlock({ (suceed, error) -> Void in
//                
//                self.actInd.stopAnimating()
//                
//                if ((error) != nil) {
//                    let alert = UIAlertController(title: "Error", message: "Oops! Username \(username) is already taken. Enter a different username.", preferredStyle: .Alert)
//                    let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
//                        //...
//                    }
//                    alert.addAction(OKAction)
//                    
//                    self.presentViewController(alert, animated: true, completion: nil)
//                    
//                }
//                else
//                {
//                    let alert = UIAlertController(title: "Success", message: "Signed Up", preferredStyle: .Alert)
//                    let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
//                        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
//                    }
//                    alert.addAction(OKAction)
//                    
//                    self.presentViewController(alert, animated: true, completion: nil)
//                    
//                }
//            })
            Alamofire.request(.POST, registerurl, parameters: ["username":usernameTF.text!, "email":emailTF.text!, "password":passwordTF.text!], encoding: .JSON).responseJSON { (req, res, json) -> Void in
                let message = JSON(json.value!)["message"]
                if (message == "registration success"){
                    let alert = UIAlertController(title: "Success", message: "Successfully Signed Up!", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                    }
                    alert.addAction(OKAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else if (message == "username already in use"){
                    let alert = UIAlertController(title: "Error", message: "Username is already taken. Select a new one.", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                        //creates the alert view if invalid login parameters are inputted
                    }
                    alert.addAction(OKAction)
                    self.actInd.stopAnimating()
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
                else{
                    let alert = UIAlertController(title: "Error", message: "Username is already taken. Select a new one.", preferredStyle: .Alert)
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
