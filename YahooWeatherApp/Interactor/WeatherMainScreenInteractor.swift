//
//  WeatherMainScreenInteractor.swift
//  YahooWeatherApp
//
//  Created by MANOJ AHER on 5/22/18.
//  Copyright © 2018 MANOJ AHER. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherMainScreenInteractor: NSObject, WeatherMainScreenInteractorInputProtocol, CLLocationManagerDelegate {
    
    weak var presenter: WeatherMainScreenInteractorOutputProtocol?
    var remoteRequestHandler: WeatherRemoteDataManagerInputProtocol?
    var locationManager = CLLocationManager()
    
    func getWeather(for location: Location?) {
        if location == nil {
            loadDefaultLocation { (success, response, error) in
                if let location = response as? Location {
                    self.remoteRequestHandler?.getWeather(for: location)
                }
            }
        } else {
            remoteRequestHandler?.getWeather(for: location!)
        }
    }
    
    func cancelAllTasks() {
        remoteRequestHandler?.cancelAllTasks()
    }
    
    func loadDefaultLocation(_ completionBlock: @escaping CompletionBlock ) {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        // Check for permission
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .authorizedAlways, .authorizedWhenInUse:
                let latitude: CLLocationDegrees = (locationManager.location?.coordinate.latitude)!
                let longitude: CLLocationDegrees = (locationManager.location?.coordinate.longitude)!
                let location = CLLocation(latitude: latitude, longitude: longitude) //changed!!!
                CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                    if let country = placemarks?.first?.country,
                        let city = placemarks?.first?.locality {
                        let location = Location()
                        location.city = city
                        location.country = country
                        completionBlock(true, location, nil)
                        return
                    }
                })
            default:
                print("Issues while getting location")
            }
            completionBlock(false, nil, nil)
        }
    }
    
    func showAlertMessage(messageTitle: NSString, withMessage: NSString) ->Void  {
        let alertController = UIAlertController(title: messageTitle as String, message: withMessage as String, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Settings", style: .default) { (action:UIAlertAction!) in
            if let url = URL(string: "App-Prefs:root=Privacy&path=LOCATION/com.company.AppName") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        alertController.addAction(OKAction)
    }
    
    private func processForecastData(data: [String: Any]) {
        if let query = data["query"] as? [String: Any],
            let results = query["results"] as? [String: Any],
            let channel = results["channel"] as? [String: Any] {
            
            let weather = Weather()
            weather.parseJson(channel)
            presenter?.reterivedForcast(weather)
        } else {
            presenter?.onError()
        }
    }

}

extension WeatherMainScreenInteractor: WeatherRemoteDataManagerOutputProtocol {
    func didReceiveForecast(data: [String : Any]) {
        processForecastData(data: data)
    }
    
    func errorOccured() {
        presenter?.onError()
    }
}
