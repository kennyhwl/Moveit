//
//  RegisterPageViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 8/9/16.
//  Copyright © 2016 Kenny Ho. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(sender: AnyObject) {
        
        let userEmail = userEmailTextField.text!;
        let userPassword = userPasswordTextField.text!;
        let userRepeatPassword = repeatPasswordTextField.text!;
        
        // function for alert display
       
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
        
        // check for empty fields
        
        if(userEmail.isEmpty || userPassword.isEmpty || userRepeatPassword.isEmpty)
        {
            // display alert message
            
            displayMyAlertMessage("All fields are required!");
            
            return;
            
        }
        
        // Check if Passwords Match
        
        if(userPassword != userRepeatPassword)
        {
            // display alert message
            
            displayMyAlertMessage("Passwords do not match :(");
            
            return;
            
        }
        
        // Store Data (Locally!)
  
  //------------------------------------------------------------
        
  //  NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail");
  //      NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword");
 //       NSUserDefaults.standardUserDefaults().synchronize();
        
 //-------------------------------------------------------------
        
        
        
        
        // Display alert message with confirmation after checking passwords and storing (for local only)
   //------------------------------------------------------------
//        let myAlert2 = UIAlertController(title: "Notice", message: "Registration Successful!", preferredStyle: UIAlertControllerStyle.Alert)
        
//        let confirmationAction2 = UIAlertAction(title: "Done", style: UIAlertActionStyle.Default) { action in
         // this causes the subsequent action (dismiss view) to occur after the previous action is taken (clicking done)
 //           self.dismissViewControllerAnimated(true, completion: nil)
  //      }
        
 //       myAlert2.addAction(confirmationAction2);
 
  //          self.presentViewController(myAlert2, animated: true, completion: nil)
       
  //--------------------------------------------------------------
        
        // Send data to server
        
        let myUrl = NSURL(string: "http://www.earthlandia.com/user-register/userRegister.php");
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        let postString = "email=\(userEmail)&password=\(userPassword)";
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        // task starts
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            //var err: NSError?
           
            do { let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
            
            if let parseJSON = json {
                let resultValue = parseJSON["status"] as? String
                print("result: \(resultValue)")
                
                var isUserRegistered: Bool = false;
                if(resultValue == "Success") {isUserRegistered = true;}
                
                var messageToDisplay: String = parseJSON["message"] as! String!;
                if(!isUserRegistered)
                {
                    messageToDisplay = parseJSON["message"] as! String!;
                }
                
                
                dispatch_async(dispatch_get_main_queue(), {
                   
                    // Display Alert Message
                    let myAlert = UIAlertController(title:"Alert", message: messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert);
                    
                    let okAction = UIAlertAction(title: "Ok", style:UIAlertActionStyle.Default){ action in
                        self.dismissViewControllerAnimated(true, completion: nil);
                }
                    myAlert.addAction(okAction);
                    self.presentViewController(myAlert, animated: true, completion: nil);
                });
            
            
        }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        
        
        
    
        }
        
        task.resume()
    
    
        
        

        
        
        
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