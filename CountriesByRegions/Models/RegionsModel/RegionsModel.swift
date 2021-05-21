//
//  RegionsModel.swift
//  CountriesByRegions
//
//  Created by MaksOn on 17.05.2021.
//

import Foundation

enum RegionsModel {
    case all
    case africa
    case americas
    case europe
    case asia
    case oceania
    
    var stringNameRegion: String {
        switch self {
        
        case .all:
            return "All"
        case .africa:
            return "Africa"
        case .americas:
            return "Americas"
        case .europe:
            return "Europe"
        case .asia:
            return "Asia"
        case .oceania:
            return "Oceania"
        }
    }
}

struct Region {
    var regionName: RegionsModel
    var arrayOfCountries: [CountryModel]
}

var arrayOfRegionsAndCountriesOfRegions = [Region(regionName: .all, arrayOfCountries: [CountryModel]()),
             Region(regionName: .africa, arrayOfCountries: [CountryModel]()),
             Region(regionName: .americas, arrayOfCountries: [CountryModel]()),
             Region(regionName: .europe, arrayOfCountries: [CountryModel]()),
             Region(regionName: .asia, arrayOfCountries: [CountryModel]()),
             Region(regionName: .oceania, arrayOfCountries: [CountryModel]())]
var currentRegion: RegionsModel = .all
