//
//  ViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 8/9/16.
//  Copyright © 2016 Kenny Ho. All rights reserved.
//

import UIKit
import SwiftyJSON
import UserNotifications

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var img2: UIImageView!
    //step count label
    @IBOutlet weak var stepCount: UILabel!
    //steps label
    @IBOutlet weak var stepsProgressLabel: UILabel!
    
    //steps progressview
    @IBOutlet weak var progressView: UIProgressView!
    
    //steps sync
    @IBAction func actionTriggered(_ sender: AnyObject) {
        
        //get values from fitbit
    
        let steps = Demo.sharedInstance.userDemoData["step"]["0"].int!
        
        //get from json file
        let recommendedSteps = 6500  //average is 6000 - 7000 for 19-49
        //display steps
        stepCount.text = "\(steps) steps";
        //compute the ratio for the steps done
        let ratioSteps = Float(steps)/Float(recommendedSteps);
        progressView.progress = Float(ratioSteps);
        //message display
        stepsProgressLabel.text = String(format: "%.1f", ratioSteps*100) + "%"
        let percentage: Float = ratioSteps;
        let lastStepCounter = steps;
        //store locally the percentage and steps
        UserDefaults.standard.set(percentage, forKey: "lastStoredSteps%");
        UserDefaults.standard.set(lastStepCounter, forKey: "lastStoredSteps")
    }
    
    //activity label
    @IBOutlet weak var activityLabel: UILabel!
    //activity percentage
    @IBOutlet weak var activityPercentageLabel: UILabel!
    //activity progress view
    @IBOutlet weak var activityProgressView: UIProgressView!
    
    //activity sync
    @IBAction func activitySync(_ sender: AnyObject) {
        
        //get values from Caroline for MPA/VPA
    
        
        let MPAmins = Demo.sharedInstance.userDemoData["mpa"]["0"].int!
        var MPAunits = MPAmins
        let VPAmins = Demo.sharedInstance.userDemoData["vpa"]["0"].int!
        var VPAunits = VPAmins * 2
        
        let MVPAunits = MPAunits + VPAunits
        
        
        let recommendedPA = 150
        
        let ratioPA = Float(MVPAunits)/Float(recommendedPA);
        //progress view progress
        activityProgressView.progress = Float(ratioPA);
        //activity percentage
        activityPercentageLabel.text = String(format: "%.1f", ratioPA*100) + "%"
        //activity label text
        activityLabel.text = "\(MVPAunits) units"
        //store locally the units
        UserDefaults.standard.set(MVPAunits, forKey: "lastStoredUnits");
        let percentage2 = ratioPA*100;
        UserDefaults.standard.set(percentage2, forKey: "lastStoredActivity%")
        
    }
    
    //notification function
    
    func scheduleLocal() {
        
        if #available(iOS 10.0, *) {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "Physical Activity Recommendation"
        content.body = "It seems that you may need to be more active! How about a 15-minute brisk walk later?"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default()
        
        var dateComponents = DateComponents()
        dateComponents.day = 7
        dateComponents.month = 11
        dateComponents.year = 2016
        dateComponents.hour = 11
        dateComponents.minute = 50
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "dropdown"
        {
            let popoverViewController = segue.destination
            
            popoverViewController.popoverPresentationController?.delegate = self
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .none
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        scheduleLocal()
        
        //show last stored values before sync
        var lastStepCountPercentage = UserDefaults.standard.float(forKey: "lastStoredSteps%")
        var lastStepCount = UserDefaults.standard.float(forKey: "lastStoredSteps")
        
        print("last% = \(lastStepCountPercentage)")
        progressView.progress = lastStepCountPercentage;
        stepsProgressLabel.text = String(format: "%.1f", lastStepCountPercentage*100) + "%"
        stepCount.text = String(format: "%0.f", lastStepCount) + " steps"
        
        let lastProgressActivity = UserDefaults.standard.float(forKey: "lastStoredUnits")
        let lastProgressActivityPercentage = UserDefaults.standard.float(forKey: "lastStoredActivity%")
        activityProgressView.progress = lastProgressActivityPercentage/100;
        activityLabel.text = String(format: "%.0f", lastProgressActivity) + " units"
        activityPercentageLabel.text = String(format: "%.1f", lastProgressActivityPercentage) + "%"
        
        //rounding images
//        img.layer.cornerRadius = img.frame.size.width/2
//        img.clipsToBounds = true
        
//        img2.layer.cornerRadius = img2.frame.size.width/2
//        img2.clipsToBounds = true
        
        //getting rid of pesky navigation bar thing appearing on top
       // self.edgesForExtendedLayout = UIRectEdge.None;
        
        // Display user detail screen upon first login
        
        // Check if its first login
        
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn");
        print (isUserLoggedIn);
        
        if(isUserLoggedIn)
            
        { print("User logged in")
            
            if(UserDefaults.standard.bool(forKey: "FirstTimeLoginA1234567890123456789012345678912345678"))
                
            { //first launch will be false, so it will jump to else statement
                
                print("why am i here")
            }
                
            else {
                // display data entry screen
                
                print("this is my first time logging in")
                
           //     dispatch_async(dispatch_get_main_queue(),{
                    
                    
           //     self.performSegueWithIdentifier("FirstLogin", sender: self);
           //         })
                
                
                // show view as popover over current viewcontroller
                
                let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FirstLogin") as! FirstLoginViewController
                self.addChildViewController(popOverVC)
                popOverVC.view.frame = self.view.frame
                self.view.addSubview(popOverVC.view)
                popOverVC.didMove(toParentViewController: self)
                
                
                
                // changing key to true now to reflect subsequent (not first) launches
                
                UserDefaults.standard.set(true, forKey: "FirstTimeLoginA1234567890123456789012345678912345678");
                UserDefaults.standard.synchronize();
                print(UserDefaults.standard.bool(forKey: "FirstTimeLoginA1234567890123456789012345678912345678"));
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        // Protected screen is only supposed to show loginView if user is not logged in
        // set a variable to identify if user is logged in or not
        
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn");
        
        // boolForKey checks if the key is 1 or 0 from login script
        
        // to set it that loginView only shows when user is not logged in, check with userLoggedIn bool.
        
        if(!isUserLoggedIn)
        {
            
            // go to loginView
            
            self.performSegue(withIdentifier: "loginView", sender: self);
            
        }
    }

    // another function
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

