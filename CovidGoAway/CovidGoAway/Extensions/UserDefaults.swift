//
//  UserDefaults.swift
//  CovidGoAway
//
//  Created by Kelby Mittan on 12/11/20.
//

import Foundation

extension UserDefaults {
    
    static let lastTimeKey = "lastTimeKey"
    static let lastCheckedCases = "lastCasesKey"
    
    func getLastCheckedData() -> CountryData? {
        
        guard let savedData = UserDefaults.standard.data(forKey: UserDefaults.lastTimeKey),  let countryData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? [CountryData], let usaData = countryData.first else { return nil }
        
        return usaData
    }
    
}
