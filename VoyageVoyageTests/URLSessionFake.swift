//
//  URLSessionFake.swift
//  VoyageVoyageTests
//
//  Created by Cr3AD on 06/08/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation

class URLSessionFake: URLSession {
    
    var data: Data?
    var urlResponse: URLResponse?
    var responceError: Error?
    
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self.responceError = error
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake()
        task.data = data
        task.urlResponse = urlResponse
        task.responseError = error
        task.completionHandler = completionHandler
        return task
    }
}

class URLSessionDataTaskFake: URLSessionDataTask {
    
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)
    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?
    
    override func resume() {
        completionHandler?(Data?, URLResponse?, Error?)
    }
    
    override func cancel() {}
}
