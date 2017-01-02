//
//  FirstLoginViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 18/9/16.
//  Copyright © 2016 Kenny Ho. All rights reserved.
//

import UIKit
import SwiftyJSON

class FirstLoginViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var img: UIImageView!
    
    
    @IBAction func uploadButtonTapped(_ sender: AnyObject) {
        //choose profile picture when upload is tapped
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    
        //function to take selected image to display on view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        img.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //make img circle
        img.layer.cornerRadius = img.frame.size.width/2
        img.clipsToBounds = true
        
        // background outside of popup grayish
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(1)
        
        //show animation
        self.showAnimate()
        
        // show intro popup when user comes to this first login page
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IntroPopUp") as! IntroPopUpViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
        //mandatory declaration step for pickerview to set datasource and delegate to self
        
        facultyPicker.delegate = self;
        facultyPicker.dataSource = self;
        
        activityPicker.delegate = self;
        activityPicker.dataSource = self;
        
        //changing which row picker selects by default
        facultyPicker.selectRow(3, inComponent: 0, animated: true)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //reading user input
    @IBOutlet weak var userFirstNameTextField: UITextField!
    
    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var userAgeTextField: UITextField!
    

    
    //done button tapped
    @IBAction func closePopUpView(_ sender: AnyObject) {
        
        // store the associated textfields in a var
        
        let userFirstName = userFirstNameTextField.text!
        let userLastName = userLastNameTextField.text!
        let userAge = userAgeTextField.text!
     //   let userFaculty = userFacultyTextField.text!
        
        //function to produce alerts/notifications
        
        func displayMyAlertMessage(_ userMessage: String)
        {
            // producing the alert as a popup - style is controller
            
            let myAlert = UIAlertController(title:"Notice", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
            
            // producing the confirmation button as an action - style is action [note: handler addition is only required for functions]
            
            let confirmationAction = UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler:nil)
            
            // linking the confirmation action to the alert popup [note: this is only required for functions]
            
            myAlert.addAction(confirmationAction)
            
            self.present(myAlert, animated: true, completion: nil)
        }
        
        //check if fields are filled in
        
        if(userFirstName.isEmpty || userLastName.isEmpty || userAge.isEmpty)
        {
            // display alert message
            
            displayMyAlertMessage("All fields are required!");
            
            return;
            
        }
        
        
        
        //storing user input locally
        
        UserDefaults.standard.set(userFirstName, forKey: "userFirstName");
        UserDefaults.standard.set(userLastName, forKey: "userLastName");

        UserDefaults.standard.set(userAge, forKey: "userAge");
     //   UserDefaults.standard.set(userFaculty, forKey: "userFaculty")
        
        UserDefaults.standard.synchronize();
        
       
        
        //need to add code to read image and send to server side
        
       //saving faculty from picker (to be changed to JSON format)
        
        print(chosenFaculty)
        
        switch (chosenFaculty)
        {
        case 0:
            UserDefaults.standard.set("Faculty of Arts & Social Science", forKey: "userFaculty")
        case 1:
            UserDefaults.standard.set("Faculty of Business and Accountancy", forKey: "userFaculty")
        case 2:
            UserDefaults.standard.set("Faculty of Dentistry", forKey: "userFaculty")
        case 3:
            UserDefaults.standard.set("Faculty of Engineering", forKey: "userFaculty")
        case 4:
            UserDefaults.standard.set("Faculty of Law", forKey: "userFaculty")
        case 5:
            UserDefaults.standard.set("Faculty of Science", forKey: "userFaculty")
        case 6:
            UserDefaults.standard.set("School of Computing", forKey: "userFaculty")
        case 7:
            UserDefaults.standard.set("School of Design and Environment", forKey: "userFaculty")
        case 8:
            UserDefaults.standard.set("Yong Loo Lin School of Medicine", forKey: "userFaculty")
        case 9:
            UserDefaults.standard.set("Yong Siew Toh Conservatory of Music", forKey: "userFaculty")
        default:
            UserDefaults.standard.set("No Faculty", forKey: "userFaculty")
        
        
        }
        
        print(chosenActivity)
        
        switch (chosenActivity)
        {
        case 0:
            UserDefaults.standard.set("Moderate", forKey: "userActivityLevel")
        case 1:
            UserDefaults.standard.set("High", forKey: "userActivityLevel")
        
        default:
            UserDefaults.standard.set("Normal", forKey: "userActivityLevel")
        }
        
        
        //insert code to save to json file here!
        
        //setting unique user ID for user when he registers (for json file naming)
        let userJSONuuid = UUID().uuidString
        
        //creating JSON object to contain user profiling
        
        var userProfile:JSON = [:] //create empty JSON array
        
        //create activity level segment in JSON array
        userProfile["activityLevelJSON"].string = UserDefaults.standard.object(forKey: "userActivityLevel") as! String?
        //create faculty segment in JSON array
        userProfile["userFacultyJSON"].string = UserDefaults.standard.object(forKey: "userFaculty") as! String?
        //create first name segment in JSON array
        userProfile["userFirstNameJSON"].string = UserDefaults.standard.object(forKey: "userFirstName") as! String?
        //create last name segment in JSON array
        userProfile["userLastNameJSON"].string = UserDefaults.standard.object(forKey: "userLastName") as! String?
        //create age segment in JSON array
        userProfile["userAgeJSON"].string = UserDefaults.standard.object(forKey: "userAge") as! String?
        //create UUID segment in JSON array
        userProfile["userUUIDJSON"].string = userJSONuuid
        
        print("this is JSON object \(userProfile)")
        
        let name = userProfile["userFirstNameJSON"].stringValue
        print("this is the name recorded in the JSON file: \(name)")
        
   //     let savedJSON = FileSaveHelper(fileName: userJSONuuid, fileExtension: .JSON, subDirectory: "ActivityData", directory: .documentDirectory)
   //         do {
 //               try savedJSON.saveFile(dataForJson: userProfile as AnyObject)
  //          }
  //          catch {
//                print(error)
 //           }
            // print("JSON file exists: \(savedJSON.fileExists)")
        
        // close the data entry view
        
        self.removeAnimate()

    }
    
    // functions to show message pop up and close it
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool) in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    //picker view codes
    
    @IBOutlet weak var facultyPicker: UIPickerView!
    
    @IBOutlet weak var activityPicker: UIPickerView!
    
    // FOR FACULTY PICKER
    
    // setting array that stores all the faculty names
    var chooseFaculty = ["Faculty of Arts & Social Science", "Faculty of Business and Accountancy", "Faculty of Dentistry", "Faculty of Engineering", "Faculty of Law", "Faculty of Science", "School of Computing", "School of Design and Environment", "Yong Loo Lin School of Medicine", "Yong Siew Toh Conservatory of Music"]
    
    
    //variable to store selected faculty
    var chosenFaculty = 0
    
    //change font
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        if(pickerView.tag == 1) {
        let data = chooseFaculty[row]
            let title = NSAttributedString(string: data, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightRegular)])
            label?.attributedText = title
            label?.textAlignment = .center
            return label!
        } else {
            let data = chooseActivity[row]
            let title = NSAttributedString(string: data, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightRegular)])
            label?.attributedText = title
            label?.textAlignment = .center
            return label!
        }
        
    }
    
    //function to set faculty names to specific row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView.tag == 1) {
            return chooseFaculty[row]
        }
        else {
            return chooseActivity[row]
        }
        
    }
    
    //function to determine number of rows in picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView.tag == 1) {
            return chooseFaculty.count
        }
        else {
            return chooseActivity.count
        }
    }
    
    //mandatory defining of how many components in picker view (one column)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1;
    }
    
    //selected row to variable chosenActivity
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pickerView.tag == 1) {
            return chosenFaculty = row
        }
        else {
            return chosenActivity = row
        }
    }
    
    // FOR ACTIVITY PICKER
    
    
    //variable to store activity level
    
    var chooseActivity = ["moderate", "high"]
    
    //variable for activity level
    
    var chosenActivity = 0
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
