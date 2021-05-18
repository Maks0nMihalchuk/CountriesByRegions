//
//  DetailInfoCountryModel .swift
//  CountriesByRegions
//
//  Created by MaksOn on 18.05.2021.
//

import Foundation

struct CountryDetailInfoModel: Codable {
    let name: String
    let population: Int
    let capital: String
    let borders: [String]
    let region: String
    let subregion: String
    let timezones: [String]
}
