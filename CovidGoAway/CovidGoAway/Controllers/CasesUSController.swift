//
//  CasesUSController.swift
//  CovidGoAway
//
//  Created by Kelby Mittan on 12/11/20.
//

import UIKit

class CasesUSController: UIViewController {

    @IBOutlet var happySadImageView: UIImageView!
    
    @IBOutlet var casesLabel: UILabel!
    
    let apiClient = APIClient()
    
    private var countries = [CountryData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCountryData()
        happySadImageView.image = UIImage(named: "cry")
    }
    
    private func getCountryData() {
        apiClient.fetchAllData { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let countries):
                DispatchQueue.main.async {
                    self?.countries = countries
                    let usa = countries.filter { $0.country == "USA" }.first
                    self?.casesLabel.text = String(usa?.todayCases ?? 99)
                    dump(countries)
                }
            }
        }
    }
}
