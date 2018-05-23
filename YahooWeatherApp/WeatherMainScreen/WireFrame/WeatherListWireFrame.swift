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
        
        let viewController = WeatherAppView(nibName: "WeatherAppView", bundle: nil)
        let interactor = WeatherMainScreenInteractor()
        let presenter = WeatherMainScreenPresenter()
        let router = WeatherListWireFrame()
        let remoteDataManager = WeatherListDataManager()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.wireFrame = router
        
        interactor.presenter = presenter
        interactor.remoteRequestHandler = remoteDataManager
        
        remoteDataManager.requestHandler = interactor
        
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}

extension WeatherListWireFrame: WeatherListWireFrameProtocol {
    func pushSearchView(navigationController: UINavigationController, callback: @escaping (Bool, AnyObject?, NSError?) -> Void) {
        let viewController = SearchLocationWireframe.createSearchLocationModule(callback: callback)
        navigationController.pushViewController(viewController, animated: true)
    }
}
