//
//  RegionsCollectionViewDataSource.swift
//  CountriesByRegions
//
//  Created by MaksOn on 17.05.2021.
//

import UIKit

class RegionsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var selectedRegion: RegionsModel = .all
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return regionsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegionCollectionViewCell.identifier,
                                                            for: indexPath) as? RegionCollectionViewCell
        
        guard let regionCell = cell else { return UICollectionViewCell()}

        let regionName = regionsArray[indexPath.item].stringNameRegion
        let isSelected = selectedRegion == regionsArray[indexPath.item]
        regionCell.configure(with: regionName, isSelected: isSelected)
        
        return regionCell
    }
}
