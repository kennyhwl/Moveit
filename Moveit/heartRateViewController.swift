//
//  heartRateViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 17/10/16.
//  Copyright © 2016 Kenny Ho. All rights reserved.
//

import UIKit

class heartRateViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
  
    @IBOutlet weak var activityLabel2: UILabel!
    
    @IBOutlet weak var activityPercentageLabel2: UILabel!
   
    @IBOutlet weak var activityProgressView2: UIProgressView!
    
    @IBOutlet weak var MAmins: UILabel!
    
    @IBOutlet weak var MAunits: UILabel!
    
    @IBOutlet weak var VAmins: UILabel!
    
    @IBOutlet weak var VAunits: UILabel!
    
    @IBOutlet weak var recommendedLabel: UILabel!
    
    @IBAction func activitySync2(_ sender: AnyObject) {
        
        //get values from fitbit JSON
        
        let MPAmins = 40
        var MPAunits = MPAmins
        let VPAmins = 30
        var VPAunits = VPAmins * 2
        
        let MVPAunits = MPAunits + VPAunits
        
        let recommendedPA = 150
        
        let ratioPA = Float(MVPAunits)/Float(recommendedPA);
        //progress view progress
        activityProgressView2.progress = Float(ratioPA);
        //activity label text
        activityLabel2.text = String(MVPAunits) + " units"
        //activity label percentage
        activityPercentageLabel2.text = String(format: "%.1f", ratioPA*100) + "%"
        
        UserDefaults.standard.set(MVPAunits, forKey: "lastStoredUnits");
        let percentage2 = ratioPA*100;
        
        UserDefaults.standard.set(percentage2, forKey: "lastStoredActivity%")
        
        UserDefaults.standard.set(MPAmins, forKey: "storedMPAmins")
        UserDefaults.standard.set(MPAunits, forKey: "storedMPAunits")
        UserDefaults.standard.set(VPAmins, forKey: "storedVPAmins")
        UserDefaults.standard.set(VPAunits, forKey: "storedVPAunits")
        UserDefaults.standard.set(MVPAunits, forKey: "storedMVPAunits")
        UserDefaults.standard.set(recommendedPA, forKey: "recommendedUnits")
        
        
        MAmins.text = String(MPAmins) + " mins"
        MAunits.text = String(MPAunits) + " units"
        VAmins.text = String(VPAmins) + " mins"
        VAunits.text = String(VPAunits) + " units"
        recommendedLabel.text = "\(MVPAunits)/\(recommendedPA) units"
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //last stored data
        
        let lastProgressActivity = UserDefaults.standard.float(forKey: "lastStoredUnits")
        let lastProgressActivityPercentage = UserDefaults.standard.float(forKey: "lastStoredActivity%")
        activityProgressView2.progress = lastProgressActivityPercentage;
        activityLabel2.text = String(format: "%.0f", lastProgressActivity) + " units"
        activityPercentageLabel2.text = String(format: "%.1f", lastProgressActivityPercentage) + "%"
        
        let lastMPAmins = UserDefaults.standard.float(forKey: "storedMPAmins")
        let lastMPAunits = UserDefaults.standard.float(forKey: "storedMPAunits")
        let lastVPAmins = UserDefaults.standard.float(forKey: "storedVPAmins")
        let lastVPAunits = UserDefaults.standard.float(forKey: "storedVPAunits")
        let lastMVPAunits = UserDefaults.standard.float(forKey: "storedMVPAunits")
        let lastRecommendedPA = UserDefaults.standard.float(forKey: "recommendedUnits")
        
        //display last stored data  
        
        MAmins.text = String(format: "%.0f", lastMPAmins) + " mins"
        MAunits.text = String(format: "%.0f", lastMPAunits) + " units"
        VAmins.text = String(format: "%.0f", lastVPAmins) + " mins"
        VAunits.text = String(format: "%.0f", lastVPAunits) + " units"
        recommendedLabel.text = String(format: "%.0f", lastMVPAunits) + " completed " + "/ " + String(format: "%.0f", lastRecommendedPA) + " recommended"
        
        
        //rounding images
        
        img.layer.cornerRadius = img.frame.size.width/2
        img.clipsToBounds = true
        
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

    

