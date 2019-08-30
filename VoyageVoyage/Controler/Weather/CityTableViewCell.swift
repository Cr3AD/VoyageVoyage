//
//  CityTableViewCell.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 27/08/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configure(cityName: String) {
        cityLabel.text = cityName
    }

}
