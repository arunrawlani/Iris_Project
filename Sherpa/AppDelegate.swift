//
//  AppDelegate.swift
//

import UIKit
import Bolts
import FBSDKLoginKit
import Parse
import ParseUI
import ParseFacebookUtilsV4



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SINClientDelegate{

    var window: UIWindow?
    var client: SINClient?
    var splash: UIImageView?
   // var logInViewController : PFLogInViewController! = PFLogInViewController()
   // var signUpViewController: PFSignUpViewController! = PFSignUpViewController()
    var requestSubmitted: Bool = false
    var isGloballyCancelled: Bool = false
    
    override init(){
        super.init()
        
    }

    //MARK: Facebook Integration
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
        
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    
        
    Parse.enableLocalDatastore()
        
    // Initialize Parse.
    Parse.setApplicationId("cllnTXXloq3Ylrju1FqAblZN4xk6rgj4jELTu5d5",
            clientKey: "7TCS6E7oOlj1YT5wpIEOs2AdkPnJTIiZBxqx94gc")
        
   
    //Initialize Facebook (boilerplate code)
    PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
    
    //check if we have logged in user
     /* let user = PFUser.currentUser()
        let startViewController: UIViewController
        
        if (user != nil){
            //if we have a user, show tab bar controller to be the initial view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            startViewController = storyboard.instantiateViewControllerWithIdentifier("NavigationControllerView") as! UIViewController
            }
        //If no user, then create a login screen. Allows for some customization, parseLoginHelper as delegate
        else {
            
            logInViewController.fields = .UsernameAndPassword | .LogInButton | .SignUpButton | .PasswordForgotten | .Facebook 
            
            startViewController = logInViewController
            
            var logInLogoTitle = UILabel()
            logInLogoTitle.text = "Sherpa"
            
            logInViewController.logInView!.logo = logInLogoTitle
            logInViewController.delegate = parseLoginHelper
            
            
            var signUpLogoTitle = UILabel()
            signUpLogoTitle.text = "Sherpa"
            signUpViewController.signUpView!.logo = signUpLogoTitle
            
            self.signUpViewController.delegate = parseLoginHelper
            
            }

        
        //creating the UIWindow. Container for all the views in our app
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = startViewController
        self.window?.makeKeyAndVisible()

*/
    
    
   /* ADDED AT HACKATHON
    application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes:
    UIUserNotificationType.Sound | UIUserNotificationType.Alert,
    categories: nil
    ))
        
    if launchOptions != nil {
        if launchOptions![UIApplicationLaunchOptionsLocalNotificationKey] != nil {
            handleLocalNotification(launchOptions![UIApplicationLaunchOptionsLocalNotificationKey] as! UILocalNotification)
        }
    }
    */
    
    //MARK: Changing the colour of the naviagtion bar
    UINavigationBar.appearance().barTintColor = UIColor(red: 74/255.0, green: 72/255.0, blue: 72/255.0, alpha: 100.0)
    UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    UINavigationBar.appearance().translucent = true
    UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
    

    return true
    //return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    //MARK: SINCH Integration
    
    func createSinchClient(userId: String) {
        if client == nil {
            client = Sinch.clientWithApplicationKey("a2bbc056-429c-4ce2-b742-1de024cc1b76", applicationSecret: "VlPqzQgjbkKd+z5KRbDC/w==", environmentHost: "sandbox.sinch.com", userId: userId)
            
            client!.setSupportCalling(true)
            client!.setSupportActiveConnectionInBackground(true)
            
            client!.delegate = self
            
            client!.start()
            client!.startListeningOnActiveConnection()
        }
    }
    
    func clientDidStart(client: SINClient) {
        NSLog("client did start")
        print(client.userId)
    }
    
    func clientDidStop(client: SINClient) {
        NSLog("client did stop")
    }
    
    func clientDidFail(client: SINClient, error: NSError!) {
        NSLog("client did fail", error.description)
        let toast = UIAlertView(title: "Failed to start", message: error.description, delegate: nil, cancelButtonTitle: "OK")
        toast.show()
    }

    
    func handleLocalNotification(notification: UILocalNotification) {
        if client != nil {
            let result: SINNotificationResult = client!.relayLocalNotification(notification)
            if result.isCall() && (result.callResult().isTimedOut) {
                let msg = "Missed call from " + result.callResult().remoteUserId
                let alert = UIAlertView()
                alert.title = "Missed call"
                alert.message = msg
                alert.show()
            }
        }
    }
    
    func dismissSplashViewIfNecessary() {
        if self.splash != nil {
            window!.bringSubviewToFront(splash!)
            UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.TransitionNone,
                animations: {
                    () -> Void in
                    self.splash!.alpha = 0.0
                },
                completion: {
                    (Bool) -> Void in
                    self.splash!.removeFromSuperview()
            })
        }
    }
    
    func addSplashView() {
        self.splash = UIImageView(frame: CGRectMake(0, 0, 320, 480))
        splash!.image = UIImage(named: "Default")
        splash!.tag = 4321
        splash!.alpha = 1.0
        
        self.window!.addSubview(splash!)
    }
    
    func showMainScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") 
        
        //As soon as login is successful, replace login screen witht tab bar
        self.window?.rootViewController!.presentViewController(tabBarController, animated:true, completion:nil)
    }

}

