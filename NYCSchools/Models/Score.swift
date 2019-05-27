//
//  Score.swift
//  20190525-AndriiKurshyn-NYCSchools
//
//  Created by Andrii Kurshyn on 5/26/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import Foundation

class Score: Codable {
    
    var testTakers: String
    var math: String
    var writing: String
    var reading: String
    
    enum CodingKeys: String, CodingKey {
        case testTakers = "num_of_sat_test_takers"
        case reading = "sat_critical_reading_avg_score"
        case writing = "sat_writing_avg_score"
        case math = "sat_math_avg_score"
    }
    
}
