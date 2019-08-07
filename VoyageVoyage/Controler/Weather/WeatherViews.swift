//
//  WeatherViews.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 31/07/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit

extension WeatherViewController {
    
    func makeimgView(with image: String) -> UIImageView {
        
        let imgView = UIImageView()
        imgView.image = UIImage(named: image)
        imgView.contentMode = .scaleAspectFit
        
        return imgView
    }
    
    func makeLabelView(with text: String) -> UILabel {
        
        let lblView = UILabel()
        lblView.text = text
        lblView.textAlignment = .center
        
        return lblView
    }
}
