//
//  dropdownMenuViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 3/1/17.
//  Copyright © 2017 Kenny Ho. All rights reserved.
//

import UIKit

class dropdownMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func LogoutButtonTapped(_ sender: AnyObject) {
    
    // set bool back to 0 (meaning logged out state)
    
    UserDefaults.standard.set(false, forKey:"isUserLoggedIn");
    
    UserDefaults.standard.synchronize();
    
    // re-present the login page again
    
    self.performSegue(withIdentifier: "loginView", sender: self);
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
