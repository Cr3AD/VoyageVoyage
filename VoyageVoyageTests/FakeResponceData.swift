//
//  FakeResponceData.swift
//  VoyageVoyageTests
//
//  Created by Cr3AD on 31/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation

class FakeResponceData {
    let responceOK = HTTPURLResponse(url: URL(string: "https://www.test.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    let responceKO = HTTPURLResponse(url: URL(string: "https://www.test.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
}

