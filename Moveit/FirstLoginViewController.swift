//
//  FirstLoginViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 18/9/16.
//  Copyright © 2016 Kenny Ho. All rights reserved.
//

import UIKit

class FirstLoginViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var img: UIImageView!
    
    
    @IBAction func uploadButtonTapped(sender: AnyObject) {
        //choose profile picture when upload is tapped
        
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(myPickerController, animated: true, completion: nil)
    }
    
    
        //function to take selected image to display on view
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        img.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //make img circle
        img.layer.cornerRadius = img.frame.size.width/2
        img.clipsToBounds = true
        
        // background outside of popup grayish
        
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(1)
        
        //show animation
        self.showAnimate()
        
        // show intro popup when user comes to this first login page
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
        
        let userFirstName = userFirstNameTextField.text!
        let userLastName = userLastNameTextField.text!
        let userAge = userAgeTextField.text!
        let userFaculty = userFacultyTextField.text!
        
        //function to produce alerts/notifications
        
        func displayMyAlertMessage(userMessage: String)
        {
            // producing the alert as a popup - style is controller
            
            let myAlert = UIAlertController(title:"Notice", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
            
            // producing the confirmation button as an action - style is action [note: handler addition is only required for functions]
            
            let confirmationAction = UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler:nil)
            
            // linking the confirmation action to the alert popup [note: this is only required for functions]
            
            myAlert.addAction(confirmationAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
        
        //check if fields are filled in
        
        if(userFirstName.isEmpty || userLastName.isEmpty || userAge.isEmpty || userFaculty.isEmpty)
        {
            // display alert message
            
            displayMyAlertMessage("All fields are required!");
            
            return;
            
        }
        
        
        
        //storing user input locally
        
        NSUserDefaults.standardUserDefaults().setObject(userFirstName, forKey: "userFirstName");
        NSUserDefaults.standardUserDefaults().setObject(userLastName, forKey: "userLastName");

        NSUserDefaults.standardUserDefaults().setObject(userAge, forKey: "userAge");
        NSUserDefaults.standardUserDefaults().setObject(userFaculty, forKey: "userFaculty")
        
        NSUserDefaults.standardUserDefaults().synchronize();
        
       // close the data entry view
        
        self.removeAnimate()
        
        //need to add code to read image and send to server side
        
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
