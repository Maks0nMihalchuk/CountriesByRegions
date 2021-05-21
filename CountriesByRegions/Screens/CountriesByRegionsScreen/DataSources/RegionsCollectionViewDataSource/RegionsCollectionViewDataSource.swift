//
//  RegionsCollectionViewDataSource.swift
//  CountriesByRegions
//
//  Created by MaksOn on 17.05.2021.
//

import UIKit

class RegionsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfRegionsAndCountriesOfRegions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegionCollectionViewCell.identifier,
                                                            for: indexPath) as? RegionCollectionViewCell
        
        guard let regionCell = cell else { return UICollectionViewCell() }

        let regionName = arrayOfRegionsAndCountriesOfRegions[indexPath.item].regionName.stringNameRegion
        let isSelected = currentRegion == arrayOfRegionsAndCountriesOfRegions[indexPath.item].regionName
        regionCell.configure(with: regionName, isSelected: isSelected)
        
        return regionCell
    }
}
