//
//  School.swift
//  20190525-AndriiKurshyn-NYCSchools
//
//  Created by Andrii Kurshyn on 5/25/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import Foundation

class School: Codable {
    
    var dbn: String
    var name: String
    var overview: String
    
    var rate: String?
    
    var neighborhood: String?
    var latitude: String?
    var longitude: String?
    
    var email: String?
    var phone: String?
    var website: String?
    
    var score: Score?
    
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case name = "school_name"
        case overview = "overview_paragraph"
        
        case rate = "graduation_rate"
        
        case neighborhood = "neighborhood"
        case latitude = "latitude"
        case longitude = "longitude"
        
        case email = "school_email"
        case phone = "phone_number"
        case website
    }
    
}

extension School {
    
    func fetchScore(completion: @escaping (Score?, Error?)->()) {
        
        if let score = self.score {
            completion(score, nil)
            return
        }
        
        let request = APIRequest.score
        request.parametrs = ["dbn": self.dbn]
        request.get([Score].self) { (score, error) in
            self.score = score?.first
            completion(self.score, error)
        }
        
    }
    
}
