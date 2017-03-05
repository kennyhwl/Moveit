//
//  GoldViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 22/2/17.
//  Copyright © 2017 Kenny Ho. All rights reserved.
//

import UIKit


class GoldViewController: UIViewController {

    
    @IBOutlet weak var currentPoints: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let showPoints = UserDefaults.standard.integer(forKey: "accountPoints")
        
        currentPoints.text = "Your current total points are \(String(showPoints))"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
