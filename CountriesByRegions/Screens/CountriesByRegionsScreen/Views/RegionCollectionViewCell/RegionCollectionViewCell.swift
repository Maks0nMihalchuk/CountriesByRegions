//
//  RegionCollectionViewCell.swift
//  CountriesByRegions
//
//  Created by MaksOn on 17.05.2021.
//

import UIKit

class RegionCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var regionNameLabel: UILabel!
    
    static let identifier = "RegionCollectionViewCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.backgroundColor = .systemIndigo
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "RegionCollectionViewCell", bundle: nil)
    }
    
    func configure(with regionName: String, isSelected: Bool) {
        regionNameLabel.text = regionName
        
        contentView.backgroundColor = isSelected ? .yellow : .systemIndigo
    }

}
