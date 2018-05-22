//
//  WeatherAppView.swift
//  YahooWeatherApp
//
//  Created by MANOJ AHER on 5/23/18.
//  Copyright © 2018 MANOJ AHER. All rights reserved.
//

import UIKit

// MARK:- WeatherAppView
class WeatherAppView: UIViewController {
    
    // MARK: Private variables
    private var weather: Weather!
    private var activityIndicator: UIActivityIndicatorView?
    private let cellIdentifier = "WeatherListCellTableViewCell"
    
    var presenter: WeatherMainScreenPresenterInputProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    // MARK: Private methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        createTableHeaderView()
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    private func createTableHeaderView() {
        if let headerView = Bundle.main.loadNibNamed("WeatherTableHeaderView", owner: self, options: nil)?.first as? WeatherTableHeaderView,
            let condition = weather?.condition,
            let astronomy = weather?.astronomy,
            let location = weather?.location {
            
            headerView.imgWeather.image = getImage(forWeatherStatus: condition.text ?? "")
            
            if let city = location.city,
                let country = location.country,
                let temp = condition.temp {
                headerView.lblTemperature.text = city + ", \(country), Current Temp: \(temp)"
            }
            headerView.lblHigh.text = (astronomy.sunrise ?? "")
            headerView.lblLow.text = (astronomy.sunset ?? "")
            headerView.imgLow.image = #imageLiteral(resourceName: "sunset")
            headerView.imgHigh.image = #imageLiteral(resourceName: "sunrise")
            tableView.tableHeaderView = headerView
        }
    }
    
    private func createLoadingView() {
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            activityIndicator!.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(activityIndicator!)
            
            var vfl = "V:|-0-[activityIndicator]-0-|"
            var vflConstraint = NSLayoutConstraint.constraints(withVisualFormat: vfl, options: [], metrics: nil, views: ["activityIndicator": activityIndicator!])
            view.addConstraints(vflConstraint)
            
            vfl = "H:|-0-[activityIndicator]-0-|"
            vflConstraint = NSLayoutConstraint.constraints(withVisualFormat: vfl, options: [], metrics: nil, views: ["activityIndicator": activityIndicator!])
            view.addConstraints(vflConstraint)
            activityIndicator!.startAnimating()
        } else {
            activityIndicator?.startAnimating()
        }
    }
    
    // MARK: Overriden methods
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
            self.createTableHeaderView()
        }, completion: nil)
    }
}


// MARK:- WeatherMainScreenViewProtocol
extension WeatherAppView: WeatherMainScreenViewProtocol {
    func showForecast(for weather: Weather) {
        self.weather = weather
        createTableHeaderView()
        navigationItem.title = weather.location?.city ?? ""
        tableView?.reloadData()
    }
    
    func showError() {
        
    }
    
    func showLoading() {
        createLoadingView()
    }
    
    func hideLoading() {
        activityIndicator?.stopAnimating()
    }
}

// MARK:- UITableViewDataSource, UITableViewDelegate
extension WeatherAppView: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather?.forcast?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WeatherListCellTableViewCell {
            if let forecast = weather?.forcast?[indexPath.row],
                let highTemprature = forecast.highTemprature,
                let lowTemprature = forecast.lowTemprature,
                let day = forecast.day?.rawValue.uppercased(),
                let date = forecast.displayDate,
                let status = forecast.status {
                cell.lblDay.text = date + ", \(day)"
                cell.lblHigh.text = "High: \(highTemprature)"
                cell.lblLow.text = "Low: \(lowTemprature)"
                cell.imgWeather.image = getImage(forWeatherStatus: status)
            }
            return cell
        }
        return UITableViewCell()
    }
}
