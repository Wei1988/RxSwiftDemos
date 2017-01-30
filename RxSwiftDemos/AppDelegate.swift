//
//  AppDelegate.swift
//  RxSwiftDemos
//
//  Created by Wei Zhang on 12/26/16.
//  Copyright © 2016 Wei Zhang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // base view controller
    var baseViewController: UIViewController?
    
    // splash view controller
    var splashViewController: SplashViewController?
    
    // launch view controller, use for app goes to background
    var launchViewController: UIViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        // set the app to always accept cookie storage
        HTTPCookieStorage.shared.cookieAcceptPolicy = .always
        
        // create session/sessionHandler with timer = 15 minutes
        
        // Set up adobe tracker
        
        
        // base view controller is a container of view controllers
        baseViewController = UIViewController()
        splashViewController = SplashViewController()
        addToBaseViewControllers(splashViewController!)
        
        // Start App
        startApp()
        
        
        window = UIWindow()
        window!.rootViewController = baseViewController!
        window!.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        
        
        // Clears the clip board
        UIPasteboard.general.items = []
        
        // Pause animation of splash view controller
        if splashViewController != nil {
            splashViewController!.stopAnimating()
        }
        
        // Put up a blocker view to hide any possible sensitive information
        launchViewController = UIStoryboard.init(name: "LaunchScreen", bundle: Bundle.main).instantiateInitialViewController()
        addToBaseViewControllers(launchViewController!)
        
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        // remove launch view controller
        if launchViewController != nil {
            removeFromBaseViewController(launchViewController!)
            launchViewController = nil
        }
        
        // resume animation of splash view controller
        if splashViewController != nil {
            splashViewController!.startAnimating()
        } else {
            splashViewController = SplashViewController()
            addToBaseViewControllers(splashViewController!)
        }
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func startApp() {
        // TEST For Now
        self.splashViewController?.stopAnimating()
        
        // #1  The basics  -- tukasz mroz
//        let cityViewController = SearchCityViewController()
//        addToBaseViewControllers(cityViewController)
        
//        let cityViewControllerII = SearchCityIIVViewController()
//        addToBaseViewControllers(cityViewControllerII)
        
        // #2  Observable and the bind
        let obBindViewController = ObservableBindingViewController()
        addToBaseViewControllers(obBindViewController)
        
        
    }
    
    
    
    
    // MARK: App functions
    func addToBaseViewControllers(_ childViewController: UIViewController) {
        baseViewController!.addChildViewController(childViewController)
        baseViewController!.view.addSubview(childViewController.view)
        childViewController.didMove(toParentViewController: baseViewController!)
    }
    
    func removeFromBaseViewController(_ childViewController: UIViewController) {
        childViewController.willMove(toParentViewController: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParentViewController()
    }

}

