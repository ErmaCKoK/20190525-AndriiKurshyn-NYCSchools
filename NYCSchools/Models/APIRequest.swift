//
//  APIRequest.swift
//  20190525-AndriiKurshyn-NYCSchools
//
//  Created by Andrii Kurshyn on 5/25/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

class APIRequest {
    
    var url: String
    var parametrs: [String: Any]?
    
    var method: HTTPMethod = .get
    
    init(_ url: String) {
        self.url = url
    }
}

extension APIRequest {
    
    @discardableResult
    func path(_ path: String) -> APIRequest {
        self.url = "\(self.url)/\(path)"
        return self
    }
    
}

extension APIRequest {
    
    func get<T: Codable>(_ codable: T.Type, completion: @escaping (T?, Error?)->()) {
        self.method = .get
        Networking.shared.execute(request: self, codable: codable, competion: completion)
    }
    
}
