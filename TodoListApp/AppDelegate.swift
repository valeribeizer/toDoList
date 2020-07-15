//
//  AppDelegate.swift
//  TodoListApp
//
//  Created by Valeryia Beizer on 6/16/20.
//  Copyright © 2020 Valeryia Beizer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    
    if let window = self.window {
      let navigationController = UINavigationController()
      navigationController.viewControllers = [RootViewController()]
      
      window.rootViewController = navigationController
      window.makeKeyAndVisible()
    }
    return true
  }
}

