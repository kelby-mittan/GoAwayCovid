//
//  CasesUSController.swift
//  CovidGoAway
//
//  Created by Kelby Mittan on 12/11/20.
//

import UIKit

class CasesUSController: UIViewController {

    let apiClient = APIClient()
    
    private var countries = [CovidDataWrapper]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCountryData()
    }
    
    private func getCountryData() {
        apiClient.fetchAllData { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let countries):
                self?.countries = countries
                dump(countries)
            }
        }
    }
}
