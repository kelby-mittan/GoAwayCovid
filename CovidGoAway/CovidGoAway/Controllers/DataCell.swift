//
//  DataCell.swift
//  CovidGoAway
//
//  Created by Kelby Mittan on 12/13/20.
//

import UIKit

class DataCell: UICollectionViewCell {
    
    @IBOutlet var dataTitleLabel: UILabel!
    
    @IBOutlet var dataLabel: UILabel!
    
    public func configCell(for data: (title: String, value: String)) {
        dataTitleLabel.text = data.title
        dataLabel.text = data.value
    }
}
