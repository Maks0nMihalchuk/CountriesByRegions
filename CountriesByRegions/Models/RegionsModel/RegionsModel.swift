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
var currentRegion: RegionsModel = .all
let regionsArray: [RegionsModel] = [.all, .africa, .americas, .europe, .asia, .oceania]
