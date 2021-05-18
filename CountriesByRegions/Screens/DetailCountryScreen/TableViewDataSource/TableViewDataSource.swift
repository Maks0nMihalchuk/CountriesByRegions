//
//  TableVIewDataSource.swift
//  CountriesByRegions
//
//  Created by MaksOn on 18.05.2021.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    
    private let defaultValue = 0
    
    var countryDetailInfo: DetailInfoModel?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let detailInfo = countryDetailInfo else { return defaultValue}
        
        return detailInfo.fieldNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let countryDetailInfoCell = tableView.dequeueReusableCell(withIdentifier: CountryDetailInfoTableViewCell.identifier,
                                                                  for: indexPath) as? CountryDetailInfoTableViewCell
        
        guard
            let cell = countryDetailInfoCell,
            let detailInfo = countryDetailInfo
        else { return UITableViewCell() }
        
        let text = "\(detailInfo.fieldNames[indexPath.row])\(detailInfo.dataArray[indexPath.row])"
        
        cell.configure(with: text)
        
        return cell
    }
}
