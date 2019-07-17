//
//  Traduction.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 29/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation
import SwiftyJSON

class TranslationManager {
    
    // Google translate API documentation :
    // https://cloud.google.com/translate/docs/?hl=fr
    
    let api = MyAPI()
    
    var textOut = ""
    
    var language:[(lang: String, short: String)] = [("English", "EN"),
                                                    ("Français", "FR"),
                                                    ("Spanish", "SP")]
    
    func makeATranslation(json: JSON) {
        let dataTranslated = json["data"]["translations"]["translatedText"].dictionaryValue
        print(dataTranslated)
        
        
        print("Traduction data did update")
        NotificationCenter.default.post(Notification(name: Notification.Name("TraductionDataDidUpdate")))
    }

    
    
    
}


