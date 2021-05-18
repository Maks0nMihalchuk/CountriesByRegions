//
//  CountryDetailInfoTableViewCell.swift
//  CountriesByRegions
//
//  Created by MaksOn on 18.05.2021.
//

import UIKit

class CountryDetailInfoTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var countryInfoLabel: UILabel!
    
    static let identifier = "CountryDetailInfoTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CountryDetailInfoTableViewCell", bundle: nil)
    }
    
    func configure(with text: String) {
        countryInfoLabel.text = text
    }
}
