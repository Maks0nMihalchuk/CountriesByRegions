//
//  CountryTableViewDataSource.swift
//  CountriesByRegions
//
//  Created by MaksOn on 17.05.2021.
//

import UIKit

class CountryTableViewDataSource: NSObject, UITableViewDataSource {
    
    private let countOffset = 1

    var countryNames = [CountryModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier,
                                                 for: indexPath) as? CountryTableViewCell

        guard let countryCell = cell else { return UITableViewCell() }
        
        let count = indexPath.row + countOffset
        
        countryCell.configure(with: "\(count). \(countryNames[indexPath.row].name)")
        
        return countryCell
    }

}
