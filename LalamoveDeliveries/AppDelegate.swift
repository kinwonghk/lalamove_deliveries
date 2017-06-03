//
//  AppDelegate.swift
//  LalamoveDeliveries
//
//  Created by Kin on 5/31/17.
//  Copyright © 2017 Kin. All rights reserved.
//

import UIKit
import SwiftyBeaver
import GSMessages
import GoogleMaps

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        bootup();
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navController = UINavigationController(rootViewController: DeliveryListViewController())
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
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
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // Receive reachability notification
    func statusManager(_ notification: NSNotification) {
        showNetworkReachability()
    }
    
    // MARK: - Bootup Method
    
    private func bootup(){
        setupLogging()
        initNetworkReachbility()
        showNetworkReachability()
        initGMS()
        NotificationCenter.default.addObserver(self, selector: #selector(statusManager), name: .flagsChanged, object: Network.reachability)
    }
    
    // Init network reachbility
    private func initNetworkReachbility(){
        do {
            Network.reachability = try Reachability(hostname: "www.google.com")
            do {
                try Network.reachability?.start()
            } catch let error as Network.Error {
                log.error(error)
            } catch {
                log.error(error)
            }
        } catch {
            log.error(error)
        }
    }
    
    // Display reachability on notification (called by statusManager when received )
    private func showNetworkReachability(){
        guard let status = Network.reachability?.status else { return }
        if (status == .unreachable){
            DispatchQueue.main.async {
                self.navController?.topViewController?.showMessage("No Internet Connection", type: .error, options: [.autoHide(true),.hideOnTap(true)])
            }
        }
    }
    
    // For setup logging
    private func setupLogging(){
        let console = ConsoleDestination() // add log destinations.
        console.format = "$Dyyyy-MM-dd HH:mm:ss.SSS$d $T $C$L$c $n($l) $F: $M" // use custom format
        console.minLevel = .verbose
        log.addDestination(console) // add the destinations to SwiftyBeaver
    }
    
    // For init Google Maps services
    private func initGMS(){
        GMSServices.provideAPIKey(Constants.GoogleMapAPI.GMSKey)
    }
}

