//
//  WeatherListWireFrame.swift
//  YahooWeatherApp
//
//  Created by MANOJ AHER on 5/23/18.
//  Copyright © 2018 MANOJ AHER. All rights reserved.
//

import UIKit

class WeatherListWireFrame: NSObject {
    
    class func createWeatherScreenModule()-> UIViewController {
        
        let presenter = WeatherMainScreenPresenter()
        let interactor = WeatherMainScreenInteractor()
        let remoteDataManager = WeatherListDataManager()
        
        
        let viewController = WeatherAppView(nibName: "WeatherAppView", bundle: nil)
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.remoteRequestHandler = remoteDataManager
        
        remoteDataManager.requestHandler = interactor
        
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
}
