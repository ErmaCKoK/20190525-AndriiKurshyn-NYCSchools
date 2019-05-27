//
//  MockURLProtocol.swift
//  20190525-AndriiKurshyn-NYCSchools
//
//  Created by Andrii Kurshyn on 5/27/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit
@testable import _0190525_AndriiKurshyn_NYCSchools

class MockURLProtocol: URLProtocol {
    
    static var responseData: Data?
    
    // MARK: - Overrides
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override func startLoading() {
        
        let response = HTTPURLResponse(url: self.request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: [:])!
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        
        if let data = MockURLProtocol.responseData {
            self.client?.urlProtocol(self, didLoad: data)
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
}

// MARK: - Register

extension MockURLProtocol {
    
    static func register(with data: Data) {
        MockURLProtocol.responseData = data
        
        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockURLProtocol.self]
        
        Networking.shared.urlSession = URLSession(configuration: config)
        MockURLProtocol.responseData = data
        
    }
    
    static func unregister() {
        Networking.shared.urlSession = URLSession(configuration: .default)
        MockURLProtocol.responseData = nil
    }
}
