//
//  API.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 17/07/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation

func valueForAPIKey(named keyname:String) -> String {
    let filePath = Bundle.main.path(forResource: "API", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value = plist?.object(forKey: keyname) as! String
    return value
}
