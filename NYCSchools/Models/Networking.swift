//
//  Networking.swift
//  20190525-AndriiKurshyn-NYCSchools
//
//  Created by Andrii Kurshyn on 5/25/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import Foundation

public enum NetworkingError: Error {
    case badInput
    case response(error: Error)
    case badResponse(error: Error)
}

// Networking that exute api requst and parce data.
class Networking: NSObject {
    
    static let shared = Networking()
    
    var urlSession: URLSession
    
    override init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let queue = OperationQueue()
        queue.name = "com.NYCSchools.Networking.Queue"
        
        self.urlSession = URLSession(configuration: config, delegate: nil, delegateQueue:queue)
        
        super.init()
    }
    
    func execute<T: Codable>(request: APIRequest, codable: T.Type, competion: @escaping (T?, Error?)->()) {
        
        var urlRequest: URLRequest!
        do {
            urlRequest = try request.urlRequest()
        }
        catch (let error){
            competion(nil, error)
            return
        }
        
        let task = self.urlSession.dataTask(with: urlRequest) { (data, respone, error) in
            
            var result: T? = nil
            var error = error
            if let data = data {
                do {
                    result = try JSONDecoder().decode(codable, from: data)
                }
                catch (let parce) {
                    error = parce
                }
                
            }
            
            DispatchQueue.main.async {
                competion(result, error)
            }
        }
        
        task.resume()
    }
}

// MARK: - APIRequest extension

private extension APIRequest {
    
    func urlRequest() throws -> URLRequest {
        let urlStr = self.url
        
        var url: URL?
        
        if let params = self.parametrs {
            let queryParams = params.map({ URLQueryItem(name: $0.key, value: "\($0.value)".urlQueryValue()) })
            
            guard var components = URLComponents(string: urlStr) else {
                throw NetworkingError.badInput
            }
            
            components.queryItems = queryParams
            
            url = components.url
        } else {
            url = URL(string: urlStr)
        }
        
        guard let URL = url else { throw NetworkingError.badInput }
        
        var urlRequest = URLRequest(url: URL)
        urlRequest.httpMethod = self.method.rawValue
        
        return urlRequest
    }
}

// MARK: - String extension

private extension String {
    
    func urlQueryValue() -> String {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~,")
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) ?? ""
    }
}

