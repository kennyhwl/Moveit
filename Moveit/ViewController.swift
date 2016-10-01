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
    
    //label
    @IBOutlet weak var progressLabel: UILabel!
    
    //view
    @IBOutlet weak var progressView: UIProgressView!
    
    //sync
    @IBAction func actionTriggered(_ sender: AnyObject) {
        
        //get values from fitbit
        let steps = 75;
        let recommended = 100;
        //compute the ratio for the steps done
        let ratio = Float(steps)/Float(recommended);
        progressView.progress = Float(ratio);
        //message display
        progressLabel.text = "\(ratio*100)%"
        let percentage = ratio;
        //store locally the percentage
        UserDefaults.standard.set(percentage, forKey: "lastStored%");
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //show last stored values before sync
        let lastProgress = UserDefaults.standard.float(forKey: "lastStored%")
        progressView.progress = lastProgress;
        progressLabel.text = "\(lastProgress*100)%"
        
        //rounding images
        img.layer.cornerRadius = img.frame.size.width/2
        img.clipsToBounds = true
        
        img2.layer.cornerRadius = img2.frame.size.width/2
        img2.clipsToBounds = true
        
        //getting rid of pesky navigation bar thing appearing on top
       // self.edgesForExtendedLayout = UIRectEdge.None;
        
        // Display user detail screen upon first login
        
        // Check if its first login
        
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn");
        print (isUserLoggedIn);
        
        if(isUserLoggedIn)
            
        { print("User logged in")
            
            if(UserDefaults.standard.bool(forKey: "FirstTimeLogin!!!!!!!!"))
                
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
                
                UserDefaults.standard.set(true, forKey: "FirstTimeLogin!!!!!!!!");
                UserDefaults.standard.synchronize();
                print(UserDefaults.standard.bool(forKey: "FirstTimeLogin!!!!!!!"));
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

    @IBAction func LogoutButtonTapped(_ sender: AnyObject)
    {
        // set bool back to 0 (meaning logged out state)
        
        UserDefaults.standard.set(false, forKey:"isUserLoggedIn");
        
        UserDefaults.standard.synchronize();
       
        // re-present the login page again
        
         self.performSegue(withIdentifier: "loginView", sender: self);
        
    }
}

