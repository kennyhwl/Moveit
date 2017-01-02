//
//  DemoData.swift
//  Moveit
//
//  Created by Kenny Ho on 30/10/16.
//  Copyright © 2016 Kenny Ho. All rights reserved.
//

import Foundation
import SwiftyJSON

class Demo {
    static let sharedInstance = Demo()
    
    
    let userDemoData:JSON = ["mpa":["6":15,"5":0,"4":0,"3":0,"2":0,"1":0,"0":10],"vpa":["6":0,"5":0,"4":0,"3":0,"2":0,"1":0,"0":15],"step":["6":6979,"5":5916,"4":7734,"3":4446,"2":3138,"1":8299,"0":13617]]
    
   // var userDemoData: JSON = ["step": ["6": 6200, "5": 5500, "4": 5255, "3": 2051, "2": 9002, "1": 1555, "0": 250],
                     //         "vpa": ["6": 20, "5": 15, "4": 0, "3": 0, "2": 0, "1": 15, "0": 0],
//                              "mpa": ["6": 16, "5": 10, "4": 12, "3": 20, "2": 25, "1": 15, "0": 10]]

}

class Notify{
    static let sharedInstance = Notify()
    
    var userNotifyData: JSON = [
    
    
                                ]
    
    
    
}

