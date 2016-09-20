//
//  ViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 8/9/16.
//  Copyright © 2016 Kenny Ho. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var img2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //rounding images
        img.layer.cornerRadius = img.frame.size.width/2
        img.clipsToBounds = true
        
        img2.layer.cornerRadius = img2.frame.size.width/2
        img2.clipsToBounds = true
        
        //getting rid of pesky navigation bar thing appearing on top
       // self.edgesForExtendedLayout = UIRectEdge.None;
        
        // Display user detail screen upon first login
        
        // Check if its first login
        
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
        print (isUserLoggedIn);
        
        if(isUserLoggedIn)
            
        { print("User logged in")
            
            if(NSUserDefaults.standardUserDefaults().boolForKey("FirstTimeLogin!!!!!!"))
                
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
                
                let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FirstLogin") as! FirstLoginViewController
                self.addChildViewController(popOverVC)
                popOverVC.view.frame = self.view.frame
                self.view.addSubview(popOverVC.view)
                popOverVC.didMoveToParentViewController(self)
                
                
                
                // changing key to true now to reflect subsequent (not first) launches
                
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstTimeLogin!!!!!!");
                NSUserDefaults.standardUserDefaults().synchronize();
                print(NSUserDefaults.standardUserDefaults().boolForKey("FirstTimeLogin!!!!!!"));
            }
        }
    }
    
    override func viewDidAppear(animated: Bool)
    {
        // Protected screen is only supposed to show loginView if user is not logged in
        // set a variable to identify if user is logged in or not
        
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
        
        // boolForKey checks if the key is 1 or 0 from login script
        
        // to set it that loginView only shows when user is not logged in, check with userLoggedIn bool.
        
        if(!isUserLoggedIn)
        {
            
            // go to loginView
            
            self.performSegueWithIdentifier("loginView", sender: self);
            
        }
    }

    // another function
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func LogoutButtonTapped(sender: AnyObject)
    {
        // set bool back to 0 (meaning logged out state)
        
        NSUserDefaults.standardUserDefaults().setBool(false, forKey:"isUserLoggedIn");
        
        NSUserDefaults.standardUserDefaults().synchronize();
       
        // re-present the login page again
        
         self.performSegueWithIdentifier("loginView", sender: self);
        
    }
}

