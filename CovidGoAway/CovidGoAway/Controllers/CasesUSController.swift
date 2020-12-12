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
    @IBOutlet var testLabel: UILabel!
    
    let apiClient = APIClient()
    
    private var countries = [CountryData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCountryData()
        happySadImageView.image = UIImage(named: "cry")
        
        testLabel.text = String(UserDefaults.standard.object(forKey: UserDefaults.lastTimeKey) as? Int ?? 0)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        saveLastChecked()
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
    
    
    private func saveLastChecked() {
        let lastChecked = countries.filter { $0.country == "USA" }
        
        UserDefaults.standard.set(lastChecked.first?.updated, forKey: UserDefaults.lastTimeKey)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        print("hey now")
//        saveLastChecked()
    }
    
}
