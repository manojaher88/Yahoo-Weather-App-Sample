//
//  SearchLocationProtocols.swift
//  YahooWeatherApp
//
//  Created by MANOJ AHER on 5/23/18.
//  Copyright © 2018 MANOJ AHER. All rights reserved.
//

import Foundation

// MARK:- Remote Data Manager
// Output protocol
protocol SearchLocationDataManagerOutputProtocol: class {
    // Remote Data manager -> Inteactor
    func didReceiveLocations(data: [String: Any])
    func errorOccured()
}

// Input protocol
protocol SearchLocationDataManagerInputProtocol {
    var requestHandler: SearchLocationDataManagerOutputProtocol? {get set}
    func getLocations(forSearchText text : String)
    func cancelAllTasks()
}


// MARK:- Interactor
// Input protocol
protocol SearchLocationInteractorInputProtocol: class {
    var presenter: SearchLocationInteractorOutputProtocol? { get set }
    var remoteRequestHandler: SearchLocationDataManagerInputProtocol? { get set }
    // INTERACTOR -> REMOTEDATAMANAGER
    func getLocations(forText text : String)
    func cancelAllTasks()
}

// Interactor
// Output protocol
protocol SearchLocationInteractorOutputProtocol: class {
    func reterivedLocations(_ weatherList: [Weather])
    func onError()
}


// MARK:- Presenter
// Input protocol
protocol SearchLocationPresenterInputProtocol: class {
    // VIEW -> PRESENTER
    var view: SearchLocationScreenViewProtocol? { get set }
    var interactor: SearchLocationInteractorInputProtocol? { get set }
    var wireFrame: SearchLocationWireFrameProtocol? { get set }
    func viewDidLoad()
    func searchLocation(forText text: String)
}

// // MARK:- View
protocol SearchLocationScreenViewProtocol: class {
    var presenter: SearchLocationPresenterInputProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showLocations(for weathers: [Weather])
    func showError()
    func showLoading()
    func hideLoading()
}

// // MARK:- Router
protocol SearchLocationWireFrameProtocol {
    func showSearchView()
}
