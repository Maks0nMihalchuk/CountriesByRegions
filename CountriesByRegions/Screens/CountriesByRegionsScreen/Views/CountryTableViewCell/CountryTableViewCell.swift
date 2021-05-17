//
//  CountryTableViewCell.swift
//  CountriesByRegions
//
//  Created by MaksOn on 17.05.2021.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var countryNameLabel: UILabel!
    
    static let identifier = "CountryTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CountryTableViewCell", bundle: nil)
    }
    
    func configure(with countryName: String) {
        countryNameLabel.text = countryName
    }
}
