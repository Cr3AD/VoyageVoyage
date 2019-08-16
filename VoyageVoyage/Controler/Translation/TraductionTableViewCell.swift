//
//  TraductionTableViewCell.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 13/08/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit

class TranslationTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeDesign()
    }
    
    @IBOutlet weak var LangInLabel: UILabel!
    @IBOutlet weak var LangOuLabel: UILabel!
    @IBOutlet weak var OriginalTextLabel: UILabel!
    @IBOutlet weak var TranlatedTextLabel: UILabel!
    @IBOutlet weak var LangInBackgroundView: UIView!
    @IBOutlet weak var LangOutBackgroundView: UIView!
    @IBOutlet weak var LangInBackgroundLabel: UIView!
    @IBOutlet weak var LangOutBackgroundLabel: UIView!
    
    func configure(langIn: String, langOut: String, tranlatedText: String, originalText: String) {
        LangInLabel.text = langIn
        LangOuLabel.text = langOut
        TranlatedTextLabel.text = tranlatedText
        OriginalTextLabel.text = originalText
    }
    
    func makeDesign() {
        /*LangInBackgroundView.layer.cornerRadius = 15
        LangOutBackgroundView.layer.cornerRadius = 15
        LangInBackgroundLabel.layer.cornerRadius = 45
        LangOutBackgroundLabel.layer.cornerRadius = 45*/
    }
}

