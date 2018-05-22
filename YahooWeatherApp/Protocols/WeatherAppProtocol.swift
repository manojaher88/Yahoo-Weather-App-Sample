//
//  WeatherAppProtocol.swift
//  YahooWeatherApp
//
//  Created by MANOJ AHER on 5/23/18.
//  Copyright © 2018 MANOJ AHER. All rights reserved.
//

import Foundation

// Remote Data Manager

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


// Interactor
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


// Presenter
// Input protocol
protocol WeatherMainScreenPresenterInputProtocol: class {
    // VIEW -> PRESENTER
    var view: WeatherMainScreenViewProtocol? { get set }
    var interactor: WeatherMainScreenInteractorInputProtocol? { get set }
    var wireFrame: WeatherListWireFrameProtocol? { get set }
    func viewDidLoad()
    func showCitySearchScreen()
}

// View
protocol WeatherMainScreenViewProtocol: class {
    var presenter: WeatherMainScreenPresenterInputProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showForecast(for weather: Weather)
    func showError()
    func showLoading()
    func hideLoading()
}

protocol WeatherListWireFrameProtocol {
    func showSearchView()
}
