//
//  AppDelegate.swift
//  Moveit
//
//  Created by Kenny Ho on 8/9/16.
//  Copyright © 2016 Kenny Ho. All rights reserved.
//

import UIKit
import UserNotifications
import Alamofire


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?

    // Caroline: Google SignIn
    // two extra functions required to solve 'appdelegate does not conform to protocol GIDSignInDelegate' problem in swift 3
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            // perform operations on signed in user here
            let userId = user.userID  // user's id in the app
            let idToken = user.authentication.idToken  // TODO: id token passed to backend server (for calendar access)
            let userName = user.profile.givenName  // call the user by his/her given name
            let email = user.profile.email
            print("current user's profile: \(userId), \(userName), \(email)")
        }
        else {
            print("\(error.localizedDescription)")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // perform any operations when the user disconnects from app here
        
    }
    // end of code for solving the above problem for Google SignIn
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("hahaha")
        // For Notifications to be sent!
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                if granted {
                    print("Yay")
                } else {
                    print("Aww")
                }
               
            }
        } else {
            // Fallback on earlier versions
        }
        
        // Change UINavigation Bar Settings (such as colour and tint)
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 240 , green: 248, blue: 255, alpha: 1)
        
        // Caroline: Google SignIn
        // Initialize sign-in process
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        GIDSignIn.sharedInstance().delegate = self
        // end of code for Google SignIn Initialize sign-in process
        
        return true
    }

    // Caroline: add url handler function (ios build-in)
    func application(_ application: UIApplication, handleOpen url: URL, options: [UIApplicationOpenURLOptionsKey: Any] = [:]) ->Bool {
        // TODO: handle multiple urls at the same time
        // Caroline: Google SignIn
        // adapted from Google SignIn API documents (syntax updated to swift 3)
        return GIDSignIn.sharedInstance().handle(url,
                                                    sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                    annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        // end of code for Google SignIn url handling process
    }
    

    // Boiler plates below
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

