//
//  StepsViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 1/10/16.
//  Copyright © 2016 Kenny Ho. All rights reserved.
//

import UIKit

class StepsViewController: UIViewController {
    
    @IBOutlet weak var img3: UIImageView!
   
    @IBOutlet weak var progressLabel2: UILabel!
    
    @IBOutlet weak var progressView2: UIProgressView!
    
    @IBAction func actionTriggered2(_ sender: AnyObject) {
        
        //get values from fitbit
        let steps = 75;
        let recommended = 100;
        //compute the ratio for the steps done
        let ratio = Float(steps)/Float(recommended);
        progressView2.progress = Float(ratio);
        //message display
        progressLabel2.text = "\(ratio*100)%"
        let percentage = ratio;
        //store locally the percentage
        UserDefaults.standard.set(percentage, forKey: "lastStored%");
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //show last stored values before sync
        let lastProgress = UserDefaults.standard.float(forKey: "lastStored%")
        progressView2.progress = lastProgress;
        progressLabel2.text = "\(lastProgress*100)%"
        
        
        //rounding images
        
        img3.layer.cornerRadius = img3.frame.size.width/2
        img3.clipsToBounds = true
    
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}



