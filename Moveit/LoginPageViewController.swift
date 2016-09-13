//
//  LoginPageViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 11/9/16.
//  Copyright © 2016 Kenny Ho. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Code to program what happens upon clicking the login button
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        let userEmail = userEmailTextField.text!;
        let userPassword = userPasswordTextField.text!;
        
        // after this step, in the real case we need to send the information above to the server for verification and return if the login is successful or not!
        
        // however, for now, just use mobile storage for verification since no server is set up yet.
        
        // code for verifying locally on phone

        // based on initially written storing code for sign up page
        
//-        let userEmailStoredLocally = NSUserDefaults.standardUserDefaults().stringForKey("userEmail");
//-        let userPasswordStoredLocally = NSUserDefaults.standardUserDefaults().stringForKey("userPassword");
        
        // now, the stored email user and password are retrieved and stored within this code. Next, verify this with login credentials.
        
//-        if(userEmail == userEmailStoredLocally)
//-        {
 //-           if(userPassword == userPasswordStoredLocally)
 //-           {
                // Login successful as both parameters matched
                
                // grant access to user's files
                
 //-               NSUserDefaults.standardUserDefaults().setBool(true, forKey:"userLoggedIn");
                
                // ^ setBool turns userLoggedIn to 1 from 0 if login is successful.
                
                // synchronize is just an action to carry out the task to access phone files from the app.
                
//-                NSUserDefaults.standardUserDefaults().synchronize();
                
                // dismissing the login page view after successful login
                
//-                self.dismissViewControllerAnimated(true, completion: nil);
                
//-            }
//-        }
        if (userEmail.isEmpty || userPassword.isEmpty) {return; }
        
        // send user data to server
        
        let myUrl = NSURL(string: "http://www.earthlandia.com/user-register/userLogin.php");
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        let postString = "email=\(userEmail)&password=\(userPassword)";
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        // task starts
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
               
                print("error=\(error)")
                
                
            }
            
         //   var err: NSError?
            do {
            var json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
            
                if let parseJSON = json {
                    var resultValue = parseJSON["status"] as? String
                    print("result: \(resultValue)")
                    
                    if(resultValue=="Success")
                    {
                        //Login is Successful
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey:"isUserLoggedIn");
                        NSUserDefaults.standardUserDefaults().synchronize();
                        self.dismissViewControllerAnimated(true, completion: nil);
                    }
                    
                    if(resultValue=="error")
                    {
                        
                        dispatch_async(dispatch_get_main_queue(), {
                        
                        let myAlert = UIAlertController(title:"Alert", message: "Incorrect fields entered", preferredStyle: UIAlertControllerStyle.Alert);
                        
                        let okAction = UIAlertAction(title: "Ok", style:UIAlertActionStyle.Default, handler: nil)
                        
                        myAlert.addAction(okAction);
                        self.presentViewController(myAlert, animated: true, completion: nil);
                    
                        });
                    }
                    
                }
            
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            
        
        }
        
        task.resume()
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
}