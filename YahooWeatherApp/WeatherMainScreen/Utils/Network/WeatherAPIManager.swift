//
//  WeatherAPIManager.swift
//  YahooWeatherApp
//
//  Created by MANOJ AHER on 5/23/18.
//  Copyright © 2018 MANOJ AHER. All rights reserved.
//

import UIKit

typealias CompletionBlock = (_ success: Bool, _ result: AnyObject?, _ error: NSError?) -> Void

class WeatherAPIManager: NSObject {
    
    // MARK:- private variables
    private var sessionManager: URLSession!
    static var sharedManager = WeatherAPIManager()
    
    // MARK:- Init
    private override init() {
        super.init()
        let sessionConfiguration = URLSessionConfiguration.default
        sessionManager = URLSession(configuration: sessionConfiguration)
    }
    
    
    // MARK:- Public methods
    @discardableResult func makeAPICall(with request: URLRequest, completionBlock: @escaping CompletionBlock)-> URLSessionTask {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let dataRequest = sessionManager.dataTask(with: request) {[weak self] (data, response, error) in
            guard let strongSelf = self else { return }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let data = data, let dict = strongSelf.convertJson(data: data) {
                completionBlock(true, dict as AnyObject, nil)
            } else {
                completionBlock(false, nil, nil)
            }
        }
        dataRequest.resume()
        return dataRequest
    }
    
    private func convertJson(data: Data) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

    
}
