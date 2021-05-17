//
//  NetworkError.swift
//  CountriesByRegions
//
//  Created by MaksOn on 17.05.2021.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData 
    
    var errorDescription: String {
        switch self {
        
        case .invalidURL:
            return "Error in url."
        case .invalidResponse:
            return "Invalid response from the server. Please try again."
        case .invalidData:
            return "The data received from the server was invalid. Please try again."
        }
    }
}
