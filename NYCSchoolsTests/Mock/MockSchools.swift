//
//  MockSchools.swift
//  20190525-AndriiKurshyn-NYCSchools
//
//  Created by Andrii Kurshyn on 5/27/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import XCTest

extension Array {
    
    var data: Data {
        return try! JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
    
}

struct Mock {
    
    static var schools: [[String: Any]] {
        
        var schools = [[String: Any]]()
        
        var dict = [String: Any]()
        dict["dbn"] = "123"
        dict["school_name"] = "Clinton School Writers"
        dict["overview_paragraph"] = "Overview 123"
        dict["graduation_rate"] = "0.1"
        dict["neighborhood"] = "Chelsea-Union"
        dict["latitude"] = "1.1"
        dict["longitude"] = "2.1"
        
        dict["school_email"] = "ermack30@gmail.com"
        dict["phone_number"] = "206-054-1111"
        dict["website"] = "www.google.com"
        schools.append(dict)
        
        dict = [:]
        dict["dbn"] = "124"
        dict["school_name"] = "Clinton School 4"
        dict["overview_paragraph"] = "Overview 4"
        dict["neighborhood"] = "Chelsea-Union 4"
        dict["latitude"] = "4.1"
        dict["longitude"] = "5.1"
        schools.append(dict)
        
        return schools
    }
    
    static var score: [[String: Any]] {
        
        var score = [[String: Any]]()
        
        var dict = [String: Any]()
        dict["num_of_sat_test_takers"] = "100"
        dict["sat_critical_reading_avg_score"] = "200"
        dict["sat_writing_avg_score"] = "250"
        dict["sat_math_avg_score"] = "300"
        score.append(dict)
        
        return score
    }
}


