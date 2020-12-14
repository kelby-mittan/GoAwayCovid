//
//  CovidCountryData.swift
//  CovidGoAway
//
//  Created by Kelby Mittan on 12/11/20.
//

import Foundation

struct CountryData: Decodable {
    let updated: Int
    let country: String
    let countryInfo: CountryInfo
    let cases: Int
    let todayCases: Int
    let deaths: Int
    let todayDeaths: Int
    let recovered: Int
    let todayRecovered: Int
    let active: Int
    let critical: Int
    let casesPerOneMillion: Double
    let deathsPerOneMillion: Double
    let tests: Int
    let testsPerOneMillion: Double
    let population: Int
    let continent: String
    let oneCasePerPeople: Int
    let oneDeathPerPeople: Int
    let oneTestPerPeople: Int
    let activePerOneMillion: Double
    let recoveredPerOneMillion: Double
    let criticalPerOneMillion: Double
    
    public func getCountryTupleArray() -> [(title: String, value: String)] {
        return [("Cases Today",self.todayCases.delimeter),("Deaths Today", self.todayDeaths.delimeter), ("Total Cases",self.cases.delimeter), ("Total Deaths",self.deaths.delimeter), ("Cases Per One Million",self.casesPerOneMillion.delimeter), ("Deaths Per One Million", self.deathsPerOneMillion.delimeter), ("Recovered Today", self.todayRecovered.delimeter), ("Total Recovered", self.recovered.delimeter)]
    }
    
}

struct CountryInfo: Decodable {
    let lat: Double
    let long: Double
    let flag: String
}

