//
//  DateString.swift
//  CovidGoAway
//
//  Created by Kelby Mittan on 12/11/20.
//

import UIKit

extension Int {
    
    func since1970ToStr() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self) / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, hh:mm"
        return dateFormatter.string(from: date)
    }
    
}
