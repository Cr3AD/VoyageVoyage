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
    }
    
    @IBOutlet weak var LangInImage: UIImageView!
    @IBOutlet weak var LangOutImage: UIImageView!
    @IBOutlet weak var OriginalTextLabel: UILabel!
    @IBOutlet weak var TranlatedTextLabel: UILabel!
    
    func configure(langIn: String, langOut: String, tranlatedText: String, originalText: String) {
        LangInImage.image = UIImage(named: langIn)
        LangOutImage.image = UIImage(named: langOut)
        TranlatedTextLabel.text = tranlatedText
        OriginalTextLabel.text = originalText
    }
    
}
