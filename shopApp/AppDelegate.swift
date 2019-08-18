//
//  AppDelegate.swift
//  shopApp
//
//  Created by Artem Esolnyak on 06/08/2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var plistPathInDocument:String = String()
    var jsonPathInDocument:String = String()
    var window: UIWindow?
   
    func preparePlistForUse(){
        
        let rootPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, .userDomainMask, true)[0]
        jsonPathInDocument = rootPath.appendingFormat("/data.json")
        plistPathInDocument = rootPath.appendingFormat("/data.plist")
        if !FileManager.default.fileExists(atPath: plistPathInDocument){
            let plistPathInBundle = Bundle.main.path(forResource: "data", ofType: "plist") as String?
            
            
            
            do {
                try FileManager.default.copyItem(atPath: plistPathInBundle!, toPath: plistPathInDocument)
                
            }catch{
                print("Error occurred while copying file to document \(error)")
            }
        }
    }
    
    
        
        func serializeDataToJSON(){
            do {
                let data:NSData =  FileManager.default.contents(atPath: plistPathInDocument)! as NSData
                let dict = try PropertyListSerialization.propertyList(from: data as Data, options: PropertyListSerialization.MutabilityOptions.mutableContainersAndLeaves, format: nil) as! NSMutableArray
                print(dict)
                let jsonData = try JSONSerialization.data(withJSONObject: dict , options: .prettyPrinted)
                try jsonData.write(to:URL.init(fileURLWithPath: jsonPathInDocument))
            } catch {
                print(error)
            }
        }
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.preparePlistForUse()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        self.preparePlistForUse()
        self.serializeDataToJSON()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

