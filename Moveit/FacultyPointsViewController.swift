//
//  FacultyPointsViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 8/3/17.
//  Copyright © 2017 Kenny Ho. All rights reserved.
//

import UIKit

class FacultyPointsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    fileprivate let reuseIdentifier = "FacultyCell"
    
    var items = ["Faculty of Engineering", "Faculty of Science", "Faculty of Arts & Social Sciences", "Faculty of Business", "School of Computing", "Faculty of Dentistry", "Faculty of Law", "School of Medicine"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        cell.myLabel.text = self.items[indexPath.item]
        cell.backgroundColor = UIColor.clear
        cell.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 3
        
        collectionView.backgroundColor = UIColor.clear
        
        return cell
        
        
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

      

        
        
        
        // Do any additional setup after loading the view.
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

extension FacultyPointsViewController {
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath as IndexPath) {
            
            var label = cell.viewWithTag(100) as? UILabel
            label?.textColor = UIColor.black
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
