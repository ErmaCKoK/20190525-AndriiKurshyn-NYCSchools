//
//  NYCAPI.swift
//  20190525-AndriiKurshyn-NYCSchools
//
//  Created by Andrii Kurshyn on 5/27/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import Foundation

// Endpoints NYC API
extension APIRequest {
    
    static var resource: APIRequest {
        return APIRequest("https://data.cityofnewyork.us/resource")
    }
    
    static var schools: APIRequest {
        return APIRequest.resource.path("97mf-9njv.json")
    }
    
    static var score: APIRequest {
        return APIRequest.resource.path("734v-jeq5.json")
    }
    
}
