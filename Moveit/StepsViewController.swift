//
//  StepsViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 1/10/16.
//  Copyright © 2016 Kenny Ho. All rights reserved.
//

import UIKit
import SwiftyJSON

class StepsViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var img3: UIImageView!
   
    @IBOutlet weak var progressLabel2: UILabel!
    
    @IBOutlet weak var stepsLabel: UILabel!
  
    @IBOutlet weak var progressView2: UIProgressView!
    
    @IBAction func actionTriggered2(_ sender: AnyObject) {
        
        
        //get values from fitbit
        let steps = Demo.sharedInstance.userDemoData["step"]["0"].int!;
        let recommended = 6500;
        //compute the ratio for the steps done
        let ratio = Float(steps)/Float(recommended);
        progressView2.progress = Float(ratio);
        //message display
        progressLabel2.text = String(format: "%.1f", ratio*100) + "%"
        let percentage = ratio;
        //store locally the percentage
        UserDefaults.standard.set(percentage, forKey: "lastStored%");
        //update step count below
        stepsLabel.text = "\(steps)";
        //store steps
        let lastStepCounter = steps;
        UserDefaults.standard.set(lastStepCounter, forKey: "lastStoredSteps")
        
        
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
        
        //show last stored values before sync
        let lastProgress = UserDefaults.standard.float(forKey: "lastStored%")
        progressView2.progress = lastProgress;
        progressLabel2.text = String(format: "%.1f", lastProgress*100) + "%"
        let lastStepCount = UserDefaults.standard.float(forKey: "lastStoredSteps")
        stepsLabel.text = String(format: "%.0f", lastStepCount)
        
        
        //rounding images
        
  //      img3.layer.cornerRadius = img3.frame.size.width/2
  //      img3.clipsToBounds = true
    
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}



