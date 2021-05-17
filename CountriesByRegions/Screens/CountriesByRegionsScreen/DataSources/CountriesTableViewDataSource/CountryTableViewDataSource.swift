//
//  CountryTableViewDataSource.swift
//  CountriesByRegions
//
//  Created by MaksOn on 17.05.2021.
//

import UIKit

class CountryTableViewDataSource: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier,
                                                 for: indexPath) as? CountryTableViewCell

        guard let countryCell = cell else { return UITableViewCell() }
        
        countryCell.configure(with: "\(indexPath.row).")
        
        return countryCell
    }

}
