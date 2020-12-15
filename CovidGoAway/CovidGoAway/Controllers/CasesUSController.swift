//
//  CasesUSController.swift
//  CovidGoAway
//
//  Created by Kelby Mittan on 12/11/20.
//

import UIKit

class CasesUSController: UIViewController {
    
    // MARK: Labels + IV's
    @IBOutlet var happySadImageView: UIImageView!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var timeDateLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var covidOneIV: UIImageView!
    @IBOutlet var covidTwoIV: UIImageView!
    @IBOutlet var covidThreeIV: UIImageView!
    
    // MARK: Constraints
    @IBOutlet var maskImageCenterConstraint: NSLayoutConstraint!
    @IBOutlet var covidOneCenterConstraint: NSLayoutConstraint!
    @IBOutlet var covidTwoBottomConstraint: NSLayoutConstraint!
    @IBOutlet var covidThreeTopConstraint: NSLayoutConstraint!
    
    // MARK: Variables
    private var actionButton : ActionButton!
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
    
    private var offset: CGFloat = 0.0 {
        didSet {
            animateCovidImageViews()
        }
    }
    
    // MARK: View Hierarchy
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        maskImageCenterConstraint.constant = 0
        covidOneCenterConstraint.constant = 20
        covidTwoBottomConstraint.constant = 0
        covidThreeTopConstraint.constant = -10
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        animateCovidImageViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground(color1: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), color2: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        timeDateLabel.textColor = .white
        countryLabel.textColor = .white
        getCountryData()
        happySadImageView.image = UIImage(named: "faceMask")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        setupFloatingButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        maskImageCenterConstraint.constant -= view.bounds.width
        covidOneCenterConstraint.constant += view.bounds.width
        covidTwoBottomConstraint.constant -= view.bounds.height/2.5
        covidThreeTopConstraint.constant += view.bounds.height/2.5
        timeDateLabel.text = ""
        countryLabel.text = ""
    }
    
    private func setGradientBackground(color1: UIColor, color2: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    private func setupFloatingButtons() {
        
        let usaButton = ActionButtonItem(title: "", image: "🇺🇸".emojiToImage())
        usaButton.action = { [weak self] item in
            guard let usa = self?.countries.filter({ $0.country == "USA" }).first else {
                return
            }
            self?.countryLabel.text = usa.country
            self?.country = usa
            self?.getCountryData(self?.country?.country ?? "USA")
            self?.collectionView.reloadData()
            self?.actionButton.toggleMenu()
        }
        
        let ukButton = ActionButtonItem(title: "", image: "🇬🇧".emojiToImage())
        ukButton.action = { [weak self] item in
            guard let uk = self?.countries.filter({ $0.country == "UK" }).first else {
                return
            }
            self?.setGradientBackground(color1: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), color2: #colorLiteral(red: 0.8334953189, green: 0, blue: 0, alpha: 1))
            self?.countryLabel.text = uk.country
            self?.country = uk
            self?.getCountryData(self?.country?.country ?? "USA")
            self?.actionButton.toggleMenu()
        }
        
        let sKoreaButton = ActionButtonItem(title: "", image: "🇰🇷".emojiToImage())
        sKoreaButton.action = { [weak self] item in
            guard let sKorea = self?.countries.filter({ $0.country == "S. Korea" }).first else {
                return
            }
            self?.countryLabel.text = sKorea.country
            self?.country = sKorea
            self?.getCountryData(self?.country?.country ?? "USA")
            self?.actionButton.toggleMenu()
        }
        
        let italyButton = ActionButtonItem(title: "", image: "🇮🇹".emojiToImage())
        italyButton.action = { [weak self] item in
            guard let italy = self?.countries.filter({ $0.country == "Italy" }).first else {
                return
            }
            self?.countryLabel.text = italy.country
            self?.country = italy
            self?.getCountryData(self?.country?.country ?? "USA")
            self?.actionButton.toggleMenu()
        }
        
        let germanyButton = ActionButtonItem(title: "", image: "🇩🇪".emojiToImage())
        germanyButton.action = { [weak self] item in
            guard let germany = self?.countries.filter({ $0.country == "Germany" }).first else {
                return
            }
            self?.countryLabel.text = germany.country
            self?.country = germany
            self?.getCountryData(self?.country?.country ?? "USA")
            self?.actionButton.toggleMenu()
        }
        
        actionButton = ActionButton(attachedToView: self.view, items: [usaButton,ukButton,sKoreaButton,italyButton,germanyButton])
        actionButton.setTitle("🌎", forState: UIControl.State())
        actionButton.backgroundColor = .clear
        actionButton.action = { button in button.toggleMenu()}
        
    }
    
    private func animateCovidImageViews() {
//        if collectionView.contentOffset.x > 200 {
//            UIView.transition(with: happySadImageView, duration: 0.75, options: .transitionCrossDissolve, animations: {
//                self.happySadImageView.image = UIImage(named: "cry")
//                self.covidOneIV.alpha = 0
//            }, completion: nil)
//        }
        
        UIView.animate(withDuration: 0.55, delay: 0, options: [.curveEaseInOut,.autoreverse,.repeat]) { [weak self] in
            self?.happySadImageView.transform = CGAffineTransform(rotationAngle: -.pi/50)
        }
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseInOut,.autoreverse,.repeat]) { [weak self] in
            self?.covidOneIV.transform = CGAffineTransform(rotationAngle: -.pi/20)
            self?.covidOneIV.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        
        UIView.animate(withDuration: 0.8, delay: 0.2, options: [.curveEaseInOut,.repeat,.autoreverse]) { [weak self] in
            self?.covidTwoIV.transform = CGAffineTransform(rotationAngle: .pi/10)
            self?.covidTwoIV.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        
        UIView.animate(withDuration: 1.4, delay: 0.3, options: [.curveEaseInOut,.repeat,.autoreverse]) { [weak self] in
            self?.covidThreeIV.transform = CGAffineTransform(rotationAngle: -.pi/12)
            self?.covidThreeIV.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
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
    
    private func getCountryData(_ countryName: String = "USA") {
        apiClient.fetchAllData { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self?.timeDateLabel.text = "try again later"
            case .success(let countries):
                DispatchQueue.main.async {
                    self?.countries = countries
                    guard let usa = countries.filter({ $0.country == countryName }).first else {
                        return
                    }
                    self?.country = usa
                    self?.countryLabel.text = usa.country
                    self?.timeDateLabel.text = usa.updated.since1970ToStr()
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
        //        animateImageView()
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
