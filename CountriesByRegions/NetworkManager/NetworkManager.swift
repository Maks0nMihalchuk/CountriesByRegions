//
//  NetworkManager.swift
//  CountriesByRegions
//
//  Created by MaksOn on 17.05.2021.
//

import Foundation

class NetworkManager {
    
    static var shared = NetworkManager()
    private var reachability = try? Reachability()
    private var mapper: Mapper
    
    init() {
        mapper = Mapper()
        subscribeOnNetworkCheckNotifications()
    }

    deinit {
        unsubscribeOnNetworkCheckNotifications()
    }

    func getCountryNames(by region: RegionsModel,
                         completion: @escaping (Result<[CountryModel], NetworkError>) -> Void) {
        guard reachability?.connection == .cellular || reachability?.connection == .wifi else {
            completion(.failure(.invalidNetworkConnection))
            return
        }
        
        guard let url = getURLToGetCountries(by: region) else {
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
            }
        }
    }
    
    func getDetailedInfoAboutCountry(by countryName: String,
                                     completion: @escaping (Result<DetailInfoModel?, NetworkError>) -> Void) {
        guard reachability?.connection == .cellular || reachability?.connection == .wifi else {
            completion(.failure(.invalidNetworkConnection))
            return
        }
        
        guard let url = getURLToGetDetailInfo(by: countryName) else {
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
                let detailInfoCountry = try JSONDecoder().decode([CountryDetailInfoModel].self, from: data)
            
                let dataConversion = self.mapper.convertReceivedDataToCountryDetailInfo(from: detailInfoCountry) 
            
                completion(.success(dataConversion))
            } catch {
                completion(.failure(.invalidData))
            }
        }
    }
}

// MARK: - get URL
private extension NetworkManager {
    
    func getURLToGetCountries(by region: RegionsModel) -> URL? {
        switch region {
        case .all:
            return URL(string: "https://restcountries-v1.p.rapidapi.com/\(region.stringNameRegion.lowercased())")
        default:
            return URL(string: "https://restcountries-v1.p.rapidapi.com/region/\(region.stringNameRegion)")
        }
    }
    
    func getURLToGetDetailInfo(by countryName: String) -> URL? {
        let urlHostAllowed = "https://restcountries-v1.p.rapidapi.com/name/\(countryName)"
        let url = urlHostAllowed.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        return URL(string: url)
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

// MARK: - work with Reachability
private extension NetworkManager {
    
    func subscribeOnNetworkCheckNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityChanged(note:)),
                                               name: .reachabilityChanged,
                                               object: reachability)
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func unsubscribeOnNetworkCheckNotifications() {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: .reachabilityChanged,
                                                  object: reachability)
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi, .cellular:
            print("Connection ")
        case .unavailable, .none:
            print("No Connection")
        }
    }
}
