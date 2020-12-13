//
//  IntAndDouble.swift
//  CovidGoAway
//
//  Created by Kelby Mittan on 12/13/20.
//

import Foundation

extension Int {
    private static var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        return numberFormatter
    }()

    var delimeter: String {
        return Int.numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}

extension Double {
    var delimeter: String {
        let arr = self.description.components(separatedBy: ".")
        if (arr.last ?? "") == "0" {
            return (Int(arr.first ?? "")?.delimeter ?? "")
        }
        return (Int(arr.first ?? "")?.delimeter ?? "") + "." + (arr.last ?? "")
    }
}
