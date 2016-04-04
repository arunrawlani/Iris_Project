//
//  LoginViewController.swift
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Parse
import ParseUI


class LoginViewController: UIViewController {
  
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
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
        
        var username = self.usernameTF.text
        var password = self.passwordTF.text
        
        
        if (username!.utf16.count < 3 || password!.utf16.count < 3){ //checks if username and password is valid
            
            var alert = UIAlertController(title: "Invalid", message: "Username and Password are too short.", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                //...
            }
            alert.addAction(OKAction)
            
            self.presentViewController(alert, animated: true, completion: nil)

          }
        
        else //logs in
        {
            self.actInd.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: {(user, error) -> Void in
                
                self.actInd.stopAnimating()
                
                if ((user) != nil){
                    
                   var alert = UIAlertController(title: "Success", message: "Logged In.", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                        //...
                    }
                    alert.addAction(OKAction)
                   // self.presentViewController(alert, animated: true, completion: nil)
                    self.performSegueWithIdentifier("testSegue", sender: nil)
                   // AppDelegate().showMainScreen()
 
            }

            else
            {
                var alert = UIAlertController(title: "Error", message: "Please enter valid login parameters.", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                        //creates the alert view if invalid login parameters are inputted
                }
                alert.addAction(OKAction)
                self.presentViewController(alert, animated: true, completion: nil)
                }
            })
        }
}
   
}

//UNUSED CODE FOR TWITTER, GOOGLE AND FB LOGIN
  /*
// func loginAction() {
    let username = usernameTF.text
    let password = passwordTF.text
    
    while (username == "") {
        println("Please enter a username")
        break
    }
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    appDelegate.createSinchClient(username)
    
    //change loggedIn back to let. ALSO REMOVE THE // FROM THE FOLLOWING LINE
    //var loggedIn = Netwerker.login(username, password: password)
   
    //MAKING WIERD CHANGES POST-HACKATHON. CHECK
    let loggedIn = true
    if loggedIn {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewControllerWithIdentifier("yoyo") as! UITabBarController
      self.presentViewController(vc, animated: true, completion: nil)
    } else {
      UIAlertView(title: "Error", message: "bad login", delegate: nil, cancelButtonTitle: "Ok").show()
    }
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    self.view.endEditing(true)
  }
*/
  
 
    
    
    
    
//WILL BE IMPLEMENTED IF TIME ALLOWS. FOR NOW NORMAL LOGIN WORKS.    
/*
    @IBAction func facebookLogin() {
    println("#fuckitshipit")
//    let fbLogin = FBSDKLoginManager()
//    fbLogin.logInWithReadPermissions(["email"], handler: { (result, error) -> Void in
//      
//      let res: FBSDKLoginManagerLoginResult = result as FBSDKLoginManagerLoginResult
//      let err: NSError? = error as NSError?
//      
//      if err != nil {
//          // process error
//        println("error?")
//      } else if res.isCancelled {
//        // handle cancellations
//        println("cancellation?")
//        
//        println(res.token)
//        println(FBSDKAccessToken.currentAccessToken())
//        
//        // rock n roll
////        if (FBSDKAccessToken.currentAccessToken() != nil) {
//          FBSDKGraphRequest(graphPath: "me", parameters: nil).startWithCompletionHandler({(connection, result, error) -> Void in
//            let err: NSError? = error as NSError?
//            let res: AnyObject? = result as AnyObject?
//            if err != nil {
//              println("fetched user? \(res)")
//            }
//          })
////        }
//        
//      } else {
//        if res.grantedPermissions.contains("email") {
//          
//          println(res.token)
//          println(FBSDKAccessToken.currentAccessToken())
//          
//          // rock n roll
//          if (FBSDKAccessToken.currentAccessToken() != nil) {
//            FBSDKGraphRequest(graphPath: "me", parameters: nil).startWithCompletionHandler({(connection, result, error) -> Void in
//              let err: NSError? = error as NSError?
//              let res: AnyObject? = result as AnyObject?
//              if err != nil {
//                println("fetched user? \(res)")
//              }
//            })
//          }
//        }
//      }
//      
//      println("wut the wut")
//    })
  }
  
  @IBAction func twitterLogin() {
    println("#fuckitshipit")
  }

  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
*/
