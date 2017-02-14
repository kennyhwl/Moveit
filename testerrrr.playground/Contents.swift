//: Playground - noun: a place where people can play

import UIKit
import CoreLocation

var str = "Hello, playground"


let updatedLocation = CLLocation(latitude: 1.3067 , longitude: 103.7555)


let w = 1

var itemLocation: [CLLocation] = []

for i in 0...w{
    
    var counter = -1
    counter += 1
    
    var itemLocLa = UserDefaults.standard.double(forKey: "\(counter)Latitude")
    var itemLocLo = UserDefaults.standard.double(forKey: "\(counter)Longitude")
    
    itemLocation[counter] = CLLocation(latitude: itemLocLa, longitude: itemLocLo)
    
    print(itemLocation)
    
}

var distanceArray: [Double] = []

