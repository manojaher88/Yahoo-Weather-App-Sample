//
//  SearchLocationInteractor.swift
//  YahooWeatherApp
//
//  Created by MANOJ AHER on 5/23/18.
//  Copyright © 2018 MANOJ AHER. All rights reserved.
//

import UIKit

class SearchLocationInteractor: NSObject, SearchLocationInteractorInputProtocol {
    
    weak var presenter: SearchLocationInteractorOutputProtocol?
    var remoteRequestHandler: SearchLocationDataManagerInputProtocol?
    
    func getLocations(forText text: String) {
        remoteRequestHandler?.getLocations(forSearchText: text)
    }
    
    func cancelAllTasks() {
        remoteRequestHandler?.cancelAllTasks()
    }
}

extension SearchLocationInteractor: SearchLocationDataManagerOutputProtocol {
    func didReceiveLocations(data: [String : Any]) {
        parseReceivedLocations(data: data)
    }
    
    func errorOccured() {
        presenter?.onError()
    }
    
    private func parseReceivedLocations(data: [String: Any]) {
        if let query = data["query"] as? [String: Any],
            let results = query["results"] as? [String: Any] {
            
            var items = [[String: Any]]()
            if let channel = results["channel"] as? [[String : Any]] {
                items = channel
            } else if let channel = results["channel"] as? [String : Any] {
                items = [channel]
            }
            var weatherArray = [Weather]()
            items.forEach { (data) in
                if (data.keys.count > 1) {
                    let weather = Weather()
                    weather.parseJson(data)
                    weatherArray.append(weather)
                }
            }
            presenter?.reterivedLocations(weatherArray)
        } else {
            presenter?.onError()
        }
    }
}
