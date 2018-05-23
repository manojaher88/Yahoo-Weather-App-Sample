//
//  SearchLocationDataManager.swift
//  YahooWeatherApp
//
//  Created by MANOJ AHER on 5/23/18.
//  Copyright © 2018 MANOJ AHER. All rights reserved.
//

import UIKit

class SearchLocationDataManager: NSObject, SearchLocationDataManagerInputProtocol {
    
    weak var requestHandler: SearchLocationDataManagerOutputProtocol?
    private let apiManager = WeatherAPIManager.sharedManager
    private var dataRequests = [URLSessionTask]()
    
    func getLocations(forSearchText text: String) {
        let queryString = getLocationSearchString(for: text)
        if let newQuery  = queryString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: newQuery) {
            let urlRequest = URLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 60)
            let dataTask = apiManager.makeAPICall(with: urlRequest) {[weak self] (success, response, error) in
                if let dict = response as? [String: Any] {
                    DispatchQueue.main.async {
                        self?.requestHandler?.didReceiveLocations(data: dict)
                    }
                }
            }
            dataRequests.append(dataTask)
        } else {
            DispatchQueue.main.async {[weak self] in
                self?.requestHandler?.errorOccured()
            }
        }
    }
    
    func cancelAllTasks() {
        dataRequests.forEach({$0.cancel()})
    }
}
