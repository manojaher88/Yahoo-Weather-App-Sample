//
//  SearchLocationPresenter.swift
//  YahooWeatherApp
//
//  Created by MANOJ AHER on 5/23/18.
//  Copyright © 2018 MANOJ AHER. All rights reserved.
//

import UIKit

class SearchLocationPresenter: NSObject, SearchLocationPresenterInputProtocol {
    var view: SearchLocationScreenViewProtocol?
    var interactor: SearchLocationInteractorInputProtocol?
    var wireFrame: SearchLocationWireFrameProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
    }
    
    func searchLocation(forText text: String) {
        view?.showLoading()
        interactor?.getLocations(forText: text)
    }
}

extension SearchLocationPresenter: SearchLocationInteractorOutputProtocol {
    func reterivedLocations(_ weatherList: [Weather]) {
        view?.hideLoading()
        view?.showLocations(for: weatherList)
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
}
