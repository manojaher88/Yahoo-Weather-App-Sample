//
//  SearchLocationViewViewController.swift
//  YahooWeatherApp
//
//  Created by MANOJ AHER on 5/23/18.
//  Copyright © 2018 MANOJ AHER. All rights reserved.
//

import UIKit

class SearchLocationView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var searchTimer: Timer?
    private var weatherList: [Weather]?
    private var cellIdentifier = "cell"
    var presenter: SearchLocationPresenterInputProtocol?
    var callback: CompletionBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter?.viewDidLoad()
    }
    
    // MARK: Private methods
    private func setupViews() {
        navigationController?.navigationBar.isTranslucent = false
        searchBar.delegate = self
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

extension SearchLocationView: SearchLocationScreenViewProtocol {
    
    func showLocations(for weathers: [Weather]) {
        weatherList = weathers
        navigationItem.title = "Locations"
        tableView?.reloadData()
    }
    
    func showError() {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
}

extension SearchLocationView: UISearchBarDelegate {
    
    func searchText(text : String) {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) {[weak self] (timer) in
            timer.invalidate()
            self?.presenter?.searchLocation(forText: text)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchText(text: text)
        }
        searchBar.resignFirstResponder()
    }
}

extension SearchLocationView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let location = weatherList?[indexPath.row].location, let city = location.city, let country = location.country {
            cell.textLabel?.text = "\(city), \(country)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        callback?(true, weatherList?[indexPath.row], nil)
        navigationController?.popViewController(animated: true)
    }
}
