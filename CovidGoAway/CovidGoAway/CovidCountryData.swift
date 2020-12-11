//
//  CovidCountryData.swift
//  CovidGoAway
//
//  Created by Kelby Mittan on 12/11/20.
//

import Foundation

/*
 [
     {
         "updated": 1607717260884,
         "country": "Zimbabwe",
         "countryInfo": {
             "_id": 716,
             "iso2": "ZW",
             "iso3": "ZWE",
             "lat": -20,
             "long": 30,
             "flag": "https://disease.sh/assets/img/flags/zw.png"
         },
         "cases": 11081,
         "todayCases": 0,
         "deaths": 305,
         "todayDeaths": 0,
         "recovered": 9253,
         "todayRecovered": 0,
         "active": 1523,
         "critical": 0,
         "casesPerOneMillion": 741,
         "deathsPerOneMillion": 20,
         "tests": 189370,
         "testsPerOneMillion": 12660,
         "population": 14958320,
         "continent": "Africa",
         "oneCasePerPeople": 1350,
         "oneDeathPerPeople": 49044,
         "oneTestPerPeople": 79,
         "activePerOneMillion": 101.82,
         "recoveredPerOneMillion": 618.59,
         "criticalPerOneMillion": 0
     },
     {
         "updated": 1607717260861,
         "country": "Zambia",
         "countryInfo": {
             "_id": 894,
             "iso2": "ZM",
             "iso3": "ZMB",
             "lat": -15,
             "long": 30,
             "flag": "https://disease.sh/assets/img/flags/zm.png"
         },
         "cases": 18161,
         "todayCases": 70,
         "deaths": 365,
         "todayDeaths": 1,
         "recovered": 17329,
         "todayRecovered": 22,
         "active": 467,
         "critical": 0,
         "casesPerOneMillion": 976,
         "deathsPerOneMillion": 20,
         "tests": 471542,
         "testsPerOneMillion": 25341,
         "population": 18608060,
         "continent": "Africa",
         "oneCasePerPeople": 1025,
         "oneDeathPerPeople": 50981,
         "oneTestPerPeople": 39,
         "activePerOneMillion": 25.1,
         "recoveredPerOneMillion": 931.26,
         "criticalPerOneMillion": 0
     },
 */

struct CovidDataWrapper: Decodable {
    let country: String
}

