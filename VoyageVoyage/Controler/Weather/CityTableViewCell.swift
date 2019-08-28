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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func configure(cityName: String) {
        cityLabel.text = cityName
    }

}
