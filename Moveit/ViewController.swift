//
//  ViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 8/9/16.
//  Copyright © 2016 Kenny Ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    @IBAction func LogoutButtonTapped(sender: AnyObject)
    {
        // set bool back to 0 (meaning logged out state)
        
        NSUserDefaults.standardUserDefaults().setBool(false, forKey:"isUserLoggedIn");
        
        NSUserDefaults.standardUserDefaults().synchronize();
       
        // re-present the login page again
        
         self.performSegueWithIdentifier("loginView", sender: self);
        
    }
}

