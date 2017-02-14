//: Playground - noun: a place where people can play

import UIKit
import CoreLocation

struct userLocation {
    
    var longitude: Double
    var latitude: Double
}

struct itemLocation {
    
    var type: String
    var longitude: Double
    var latitude: Double
    
}

var myLocation = userLocation(longitude: 103.7555 , latitude: 1.3067)

var tembusu = itemLocation(type: "Bronze", longitude: 103.7635, latitude: 1.3063)
var cinnamon = itemLocation(type: "Silver", longitude: 103.7735, latitude: 1.3067 )
var yale = itemLocation(type: "Gold", longitude: 103.7705 , latitude: 1.3006)
var rc4 = itemLocation(type: " ", longitude: 103.7515, latitude: 1.3099)

var locationDatabase = [tembusu, cinnamon, yale, rc4]
print(locationDatabase.count)



func getLocation(userLoc: userLocation, locDatabase: [itemLocation], upperR: Double, lowerR: Double) -> itemLocation {
    
    let longUser = userLoc.longitude
    let latUser = userLoc.latitude
    let locUser = CLLocation(latitude: latUser, longitude: longUser)
    var locsInRange: [itemLocation] = []
    var counter = -1
    
    for i in locDatabase {
        let longItem = i.longitude
        let latItem = i.latitude
        let locItem = CLLocation(latitude: latItem, longitude: longItem)
        let dist = locItem.distance(from: locUser)
        print("this is dist \(dist)")
        
        if (dist >= lowerR) && (dist <= upperR) {
            locsInRange.append(i)
            print ("this is locsInRange \(locsInRange)")
            
            counter += 1
            
            if (dist <= 0.333 * upperR){
                locsInRange[counter].type = "Bronze"
            }
            if (dist <= 0.667 * upperR) && (dist > 0.333 * upperR){
                locsInRange[counter].type = "Silver"
            }
            if (dist > 0.667 * upperR){
                locsInRange[counter].type = "Gold"
            }
            
            
        }
        
    }
    print("This is the appended locsInRange Array: \(locsInRange)")
    print(locsInRange.count)
    let w = locsInRange.count
    for i in 1...w{
        
        UserDefaults.standard.set(locsInRange[i].longitude, forKey: "\(i)Longitude")
        UserDefaults.standard.set(locsInRange[i].latitude, forKey: "\(i)Latitude")
        print(locsInRange[i].longitude)
    }
    
    let listLength = locsInRange.count
    let random = Int(arc4random_uniform(UInt32(listLength)))
    print ("this is random \(random)")
    return locsInRange[random]
}


var selectedLocation = getLocation(userLoc: myLocation, locDatabase: locationDatabase, upperR: 1000, lowerR: 200)

print("this is selected location: \(selectedLocation)")

let loc1 = CLLocation(latitude: 103.7555, longitude: 1.3067)
let loc2 = CLLocation(latitude: 103.7705, longitude: 1.3006)

let distanceInMeters = loc1.distance(from: loc2)
print(distanceInMeters)









