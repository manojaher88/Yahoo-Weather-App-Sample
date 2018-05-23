//
//  WeatherAppProtocol.swift
//  YahooWeatherApp
//
//  Created by MANOJ AHER on 5/23/18.
//  Copyright © 2018 MANOJ AHER. All rights reserved.
//

import Foundation
import UIKit

// MARK:- Remote Data Manager
// Output protocol
protocol WeatherRemoteDataManagerOutputProtocol: class {
    // Remote Data manager -> Inteactor
    func didReceiveForecast(data: [String: Any])
    func errorOccured()
}

// Input protocol
protocol WeatherRemoteDataManagerInputProtocol {
    var requestHandler: WeatherRemoteDataManagerOutputProtocol? {get set}
    func getWeather(for location : Location)
    func cancelAllTasks()
}


// MARK:- Interactor
// Input protocol
protocol WeatherMainScreenInteractorInputProtocol: class {
    var presenter: WeatherMainScreenInteractorOutputProtocol? { get set }
    var remoteRequestHandler: WeatherRemoteDataManagerInputProtocol? { get set }
    // INTERACTOR -> REMOTEDATAMANAGER
    func getWeather(for location : Location?)
    func cancelAllTasks()
}

// Interactor
// Output protocol
protocol WeatherMainScreenInteractorOutputProtocol: class {
    func reterivedForcast(_ weather: Weather)
    func onError()
}


// MARK:- Presenter
// Input protocol
protocol WeatherMainScreenPresenterInputProtocol: class {
    // VIEW -> PRESENTER
    var view: WeatherMainScreenViewProtocol? { get set }
    var interactor: WeatherMainScreenInteractorInputProtocol? { get set }
    var wireFrame: WeatherListWireFrameProtocol? { get set }
    func viewDidLoad()
    func showCitySearchScreen(_ navigation: UINavigationController, completionBlock: @escaping CompletionBlock)
}

// // MARK:- View
protocol WeatherMainScreenViewProtocol: class {
    var presenter: WeatherMainScreenPresenterInputProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showForecast(for weather: Weather)
    func showError()
    func showLoading()
    func hideLoading()
}

// // MARK:- Router
protocol WeatherListWireFrameProtocol {
    func pushSearchView(navigationController: UINavigationController, callback: @escaping (Bool, AnyObject?, NSError?) -> Void)
}
