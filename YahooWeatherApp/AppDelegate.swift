//
//  AppDelegate.swift
//  YahooWeatherApp
//
//  Created by MANOJ AHER on 5/23/18.
//  Copyright © 2018 MANOJ AHER. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let weatherScreen = WeatherListWireFrame.createWeatherScreenModule()
        weatherScreen.view.backgroundColor = .red
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = weatherScreen
        window?.makeKeyAndVisible()
        return true
    }
}
