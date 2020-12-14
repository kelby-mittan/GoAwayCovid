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
    @IBOutlet var covidOneIV: UIImageView!
    
    
    @IBOutlet var maskImageCenterConstraint: NSLayoutConstraint!
    @IBOutlet var covidOneCenterConstraint: NSLayoutConstraint!
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        maskImageCenterConstraint.constant = 0
        covidOneCenterConstraint.constant = 0
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        casesLabel.textColor = .white
        getCountryData()
        happySadImageView.image = UIImage(named: "faceMask")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        animateImageView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        maskImageCenterConstraint.constant -= view.bounds.width
        covidOneCenterConstraint.constant += view.bounds.width
        casesLabel.text = ""
    }
    
    private func setGradientBackground() {
        let color1 = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1).cgColor
        let color2 = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    private func animateImageView() {
        if collectionView.contentOffset.x > 200 {
            UIView.transition(with: happySadImageView,
                              duration: 0.75,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.happySadImageView.image = UIImage(named: "cry")
                                self.covidOneIV.alpha = 0
                              },
                              completion: nil)
        }
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
                    self?.casesLabel.text = usa.updated.since1970ToStr()
                    self?.dataTupleArr = self?.country?.getCountryTupleArray() ?? []
                }
            }
        }
    }
    
    private func saveLastChecked() {
        let lastChecked = countries.filter { $0.country == "USA" }
        
        UserDefaults.standard.set(lastChecked.first?.updated, forKey: UserDefaults.lastTimeKey)
    }
    
    private func getIndexPath(_ cv: UICollectionView) {
        let screen = UIScreen.main.bounds.width-30
        print("Screen \(screen)")
        //        print(collectionView.indexPathsForVisibleItems.first?.row)
        switch cv.contentOffset.x {
        case -100..<screen:
            print("1")
        case screen..<screen*2:
            print("2")
        case 800..<1200:
            print("3")
        case 1200..<1600:
            print("4")
        default:
            print("5")
        }
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
        cell.backgroundColor = .clear
        cell.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        cell.configCell(for: dataTupleArr[indexPath.row])
        print("YOOOO: \(collectionView.contentOffset.x)")
        //        getIndexPath()
        animateImageView()
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
