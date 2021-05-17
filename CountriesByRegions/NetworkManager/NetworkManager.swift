//
//  NetworkManager.swift
//  CountriesByRegions
//
//  Created by MaksOn on 17.05.2021.
//

import Foundation

class NetworkManager {
    
    static var shared = NetworkManager()
    
    func getCountryNames(by region: RegionsModel, completion: @escaping (Result<[CountryModel], NetworkError>) -> Void) {
        guard let url = getURL(by: region) else {
            completion(.failure(.invalidURL))
            return
        }
        
        makeDataTaskRequest(with: url) { data, error in
            if error != nil {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let countryNames = try JSONDecoder().decode([CountryModel].self, from: data)
                completion(.success(countryNames))
            } catch {
                completion(.failure(.invalidData))
                print(error)
            }
        }
    }
}

// MARK: - get URL
private extension NetworkManager {
    
    func getURL(by region: RegionsModel) -> URL? {
        switch region {
        case .all:
            return URL(string: "https://restcountries-v1.p.rapidapi.com/\(region.stringNameRegion.lowercased())")
        default:
            return URL(string: "https://restcountries-v1.p.rapidapi.com/region/\(region.stringNameRegion)")
        }
    }
}

// MARK: - setting request tasks
private extension NetworkManager {
    
    func makeDataTaskRequest(with url: URL, completion: @escaping (Data?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.addValue(HeadersForAPI.key.headerKey, forHTTPHeaderField: HeadersForAPI.key.headerName)
        request.addValue(HeadersForAPI.host.headerKey, forHTTPHeaderField: HeadersForAPI.host.headerName)
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, _, error in
            completion(data, error)
        }.resume()
    }
}
