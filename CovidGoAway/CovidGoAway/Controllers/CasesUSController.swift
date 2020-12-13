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
    @IBOutlet var collectionView: UICollectionView!
    
    let apiClient = APIClient()
    
    private var countries = [CountryData]()
    private var country: CountryData?
    
    private var dataTupleArr = [(title: String, value: String)]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCountryData()
        happySadImageView.image = UIImage(named: "face-mask")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func getLastTime() -> String {
        let secSince1970 = UserDefaults.standard.object(forKey: UserDefaults.lastTimeKey) as? Int
        guard let secInt = secSince1970?.since1970ToStr() else { return "" }
        return secInt
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
                    guard let usa = countries.filter({ $0.country == "USA" }).first else {
                        return
                    }
                    self?.country = usa
                    self?.casesLabel.text = " As of " + usa.updated.since1970ToStr()
//                    dump(countries)
                    self?.dataTupleArr = self?.country?.getCountryTupleArray() ?? []
                    dump(self?.country?.getCountryTupleArray())
                }
            }
        }
    }
    
    private func saveLastChecked() {
        let lastChecked = countries.filter { $0.country == "USA" }
        
        UserDefaults.standard.set(lastChecked.first?.updated, forKey: UserDefaults.lastTimeKey)
    }
    
    
}

extension CasesUSController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataTupleArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as? DataCell else {
            fatalError("Error dequeing cell")
        }
        cell.backgroundColor = .green
        cell.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        cell.configCell(for: dataTupleArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
