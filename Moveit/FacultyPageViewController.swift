//
//  FacultyPageViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 5/3/17.
//  Copyright © 2017 Kenny Ho. All rights reserved.
//

import UIKit

class FacultyPageViewController: UIViewController {

    @IBOutlet weak var usersName: UILabel!
    @IBOutlet weak var facultyName: UILabel!
    @IBOutlet weak var individualPoints: UILabel!
    @IBOutlet weak var facultyPoints: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        facultyName.text = UserDefaults.standard.string(forKey: "userFaculty")
        individualPoints.text = String(UserDefaults.standard.integer(forKey: "accountPoints"))
        
        usersName.text = UserDefaults.standard.string(forKey: "userFirstName")
        facultyPoints.text = String(UserDefaults.standard.integer(forKey: "facultyPoints"))
        
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
