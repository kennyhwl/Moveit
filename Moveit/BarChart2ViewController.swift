//
//  BarChart2ViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 20/10/16.
//  Copyright © 2016 Kenny Ho. All rights reserved.
//

import UIKit

import Charts

class BarChart2ViewController: UIViewController {

    
    @IBOutlet weak var barChartView2: BarChartView!
    
    @IBOutlet weak var MAmins: UILabel!
    
    @IBOutlet weak var MAunits: UILabel!
    
    @IBOutlet weak var VAmins: UILabel!
    
    @IBOutlet weak var VAunits: UILabel!
    
    @IBOutlet weak var recommendedLabel: UILabel!
    
    var days:[String] = []
    
    var MVPAdone:[Double] = [100, 100, 200, 130, 120, 150, 40, 130, 100, 50, 20, 110]

override func viewDidLoad() {
    super.viewDidLoad()

    //Get activity data based on date from JSON file data storage
    
    let dateMPAmins = 40     //all these values must be gotten from JSON files
    let dateMPAunits = dateMPAmins
    
    let dateVPAmins = 30
    let dateVPAunits = dateMPAunits * 2
    
    let dateRecommendedPA = 150
    
    let dateMVPAunits = 100
    
    MAmins.text = "\(dateMPAmins) mins"
    MAunits.text = "\(dateMPAunits) units"
    VAmins.text = "\(dateVPAmins) mins"
    VAunits.text = "\(dateVPAunits) mins"
    
     recommendedLabel.text = String(dateMVPAunits) + " completed " + "/ " + String(dateRecommendedPA) + " recommended"
    
    
    setChart()
    
    }
    
    func setChart() {
        barChartView2.noDataText = "Insufficient data for viewing historical records. More days of Fitbit data has to be acquired."
        
        //setting the days
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        let today = Date()
        
        for day in 0...6{
            //if day = 0, fromDate = 7 days ago..6..5..4..3..2..1
            let fromDate = Date(timeIntervalSinceNow: Double(-7+day) *  86400)
            //6 days ago..5..4..3..2..1..0
            let toDate = Date(timeIntervalSinceNow: Double(-7+day+1) * 86400)
            let dtStr = formatter.string(from: toDate)
            
            self.days.append(dtStr)
            
            //  print("days are \(days)")
            if(self.days.count == 7) {
                
                let xVals = self.days
                var yVals: [BarChartDataEntry] = []
                for idx in 0...6 {
                    
                    
                    yVals.append(BarChartDataEntry(x: Double(idx), y: MVPAdone[idx]))
                    // let yVals = BarChartDataEntry(x: stepsTaken[idx], y: Double(idx))
                    print("yVals are \(yVals)")
                }
                
                let yAxis = BarChartDataSet(values: yVals, label: "Steps Taken")
                
                let xAxis = BarChartData() //(xVals: xVals, dataSet: yAxis)
                
            
                
                xAxis.addDataSet(yAxis)
                barChartView2.data = xAxis
                // self.view.reloadInputViews()
                
            }
            
        }
        
      
    }
    
    
    
}


