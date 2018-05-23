//
//  WeatherListCellTableViewCell.swift
//  YahooWeatherApp
//
//  Created by MANOJ AHER on 5/23/18.
//  Copyright © 2018 MANOJ AHER. All rights reserved.
//

import UIKit

class WeatherListCellTableViewCell: UITableViewCell {

    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lblLow: UILabel!
    @IBOutlet weak var lblHigh: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblLow.text = ""
        lblHigh.text = ""
        lblDay.text = ""
        imgWeather.image = nil
    }
}
