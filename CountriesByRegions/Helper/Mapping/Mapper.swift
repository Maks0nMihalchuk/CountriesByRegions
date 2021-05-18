//
//  Mapper.swift
//  CountriesByRegions
//
//  Created by MaksOn on 18.05.2021.
//

import Foundation

class Mapper {
    
    private let lastDeletedCharacters = 2
    
    func convertReceivedDataToCountryDetailInfo(from countryDetailInfoModel: [CountryDetailInfoModel]) -> DetailInfoModel? {
        guard let countryDetailInfoModel = countryDetailInfoModel.first else { return nil}
        
        var resultArray = [String]()
        var fildNames = [String]()
            
        let timeZone = getTimezoneToCountry(from: countryDetailInfoModel.timezones)
        let borders = getBordersToCountry(from: countryDetailInfoModel.borders)
        let population = getPopulationCountry(population: countryDetailInfoModel.population)
        
        resultArray.append(countryDetailInfoModel.name)
        resultArray.append(population)
        resultArray.append(countryDetailInfoModel.capital)
        resultArray.append(borders)
        resultArray.append(countryDetailInfoModel.region)
        resultArray.append(countryDetailInfoModel.subregion)
        resultArray.append(timeZone)
        
        fildNames.append("Country name: ")
        fildNames.append("Population: ")
        fildNames.append("Сapital: ")
        fildNames.append("Countries with which borders:\n")
        fildNames.append("Region: ")
        fildNames.append("Subregion: ")
        fildNames.append("Time zone(-s):\n")

        return DetailInfoModel(fieldNames: fildNames, dataArray: resultArray)
    }
}

// MARK: - converting data about a country into a convenient form
private extension Mapper {
    
    func getTimezoneToCountry(from dataModel: [String]) -> String {
        var timeZone = String()
        
        dataModel.forEach {
            timeZone +=  "\($0)\n"
        }
        
        if timeZone.hasSuffix("\n") {
            timeZone.removeLast(lastDeletedCharacters)
        }
        
        return timeZone
    }
    
    func getBordersToCountry(from dataModel: [String]) -> String {
        var borders = String()
        
        if dataModel.isEmpty {
            return "--"
        }
        
        dataModel.forEach {
            borders += "\($0)\n"
        }
        
        if borders.hasSuffix("\n") {
            borders.removeLast(lastDeletedCharacters)
        }
        
        return borders
    }
    
    func getPopulationCountry(population: Int) -> String {
        return String(population)
    }
}
