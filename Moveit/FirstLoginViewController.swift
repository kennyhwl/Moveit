//
//  FirstLoginViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 18/9/16.
//  Copyright © 2016 Kenny Ho. All rights reserved.
//

import UIKit

class FirstLoginViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //make img circle
        img.layer.cornerRadius = img.frame.size.width/2
        img.clipsToBounds = true
        
        // background outside of popup
        
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        
        //show animation
        self.showAnimate()
        
        // show intro popup
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("IntroPopUp") as! IntroPopUpViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //reading user input
    @IBOutlet weak var userFirstNameTextField: UITextField!
    
    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var userAgeTextField: UITextField!
    @IBOutlet weak var userFacultyTextField: UITextField!

    
    //done button tapped
    @IBAction func closePopUpView(sender: AnyObject) {
        
        // store the associated textfields in a var
        
        let userFirstName = userFirstNameTextField.text
        let userLastName = userLastNameTextField.text
        let userAge = userAgeTextField.text
        let userFaculty = userFacultyTextField.text
        
        //storing user input locally
        
        NSUserDefaults.standardUserDefaults().setObject(userFirstName, forKey: "userFirstName");
        NSUserDefaults.standardUserDefaults().setObject(userLastName, forKey: "userLastName");

        NSUserDefaults.standardUserDefaults().setObject(userAge, forKey: "userAge");
        NSUserDefaults.standardUserDefaults().setObject(userFaculty, forKey: "userFaculty")
        
        NSUserDefaults.standardUserDefaults().synchronize();
        
       // close the data entry view
        
        self.removeAnimate()
        
        //self.view.removeFromSuperview()
        
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool) in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
