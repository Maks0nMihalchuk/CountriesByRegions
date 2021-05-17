//
//  HeadersForAPI.swift
//  CountriesByRegions
//
//  Created by MaksOn on 17.05.2021.
//

import Foundation

enum HeadersForAPI {
    case key
    case host
    
    var headerName: String {
        switch self {

        case .key:
            return "x-rapidapi-key"
        case .host:
            return "x-rapidapi-host"
        }
    }
    
    var headerKey: String {
        switch self {

        case .key:
            return "f2b65a382amsh8044b4f24a26fc6p1a69ddjsna76f2721d1cd"
        case .host:
            return "restcountries-v1.p.rapidapi.com"
        }
    }
}
