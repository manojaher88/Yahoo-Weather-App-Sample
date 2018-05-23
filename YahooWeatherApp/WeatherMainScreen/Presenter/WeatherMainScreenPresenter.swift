//
//  WeatherMainScreenPresenter.swift
//  YahooWeatherApp
//
//  Created by MANOJ AHER on 5/23/18.
//  Copyright © 2018 MANOJ AHER. All rights reserved.
//

import UIKit

class WeatherMainScreenPresenter: NSObject, WeatherMainScreenPresenterInputProtocol {
    weak var view: WeatherMainScreenViewProtocol?
    var interactor: WeatherMainScreenInteractorInputProtocol?
    var wireFrame: WeatherListWireFrameProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.getWeather(for: nil)
    }
    
    func showCitySearchScreen(_ navigation: UINavigationController, completionBlock: @escaping CompletionBlock) {
        wireFrame?.pushSearchView(navigationController: navigation, callback: completionBlock)
    }
}

extension WeatherMainScreenPresenter: WeatherMainScreenInteractorOutputProtocol {
    func reterivedForcast(_ forecast: Weather) {
        view?.hideLoading()
        view?.showForecast(for: forecast)
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
}
