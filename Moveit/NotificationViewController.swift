//
//  NotificationViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 2/11/16.
//  Copyright © 2016 Kenny Ho. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class NotificationViewController: UIViewController {
    
    func registerLocal() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            
            center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                
                if granted {
                    print("Yay!")
                } else {
                    print("Aww")
                }
                
            }
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    
    func scheduleLocal() {
        
    }

override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}


}
