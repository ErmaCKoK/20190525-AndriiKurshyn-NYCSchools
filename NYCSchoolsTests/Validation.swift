//
//  Validation.swift
//  20190525-AndriiKurshyn-NYCSchools
//
//  Created by Andrii Kurshyn on 5/27/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import XCTest
@testable import _0190525_AndriiKurshyn_NYCSchools

struct Validation {
    
    static func validation(_ school: School, moc: [String: Any]) {
        
        let errorMessage: (String) -> (String) = { key in "School validator's failed for \(key)" }
        
        // Validated properties of class
        XCTAssertEqual(school.dbn, moc["dbn"] as! String, errorMessage("dbn"))
        XCTAssertEqual(school.name, moc["school_name"] as! String, errorMessage("name"))
        XCTAssertEqual(school.overview, moc["overview_paragraph"] as! String, errorMessage("overview"))
        XCTAssertEqual(school.neighborhood, moc["neighborhood"] as? String, errorMessage("neighborhood"))
        
        XCTAssertEqual(school.latitude, moc["latitude"] as? String, errorMessage("latitude"))
        XCTAssertEqual(school.longitude, moc["longitude"] as? String, errorMessage("longitude"))
        
        XCTAssertEqual(school.email, moc["school_email"] as? String, errorMessage("email"))
        XCTAssertEqual(school.phone, moc["phone_number"] as? String, errorMessage("phone"))
        XCTAssertEqual(school.website, moc["website"] as? String, errorMessage("website"))
        
    }
    
    static func validation(_ score: Score?, moc: [String: Any]) {
        
        if score == nil && moc.isEmpty {
            return
        }
        
        let errorMessage: (String) -> (String) = { key in "Score validator's failed for \(key)" }
        
        // Validated properties of class
        XCTAssertEqual(score?.testTakers, moc["num_of_sat_test_takers"] as? String, errorMessage("testTakers"))
        XCTAssertEqual(score?.math, moc["sat_math_avg_score"] as? String, errorMessage("math"))
        XCTAssertEqual(score?.writing, moc["sat_writing_avg_score"] as? String, errorMessage("writing"))
        XCTAssertEqual(score?.reading, moc["sat_critical_reading_avg_score"] as? String, errorMessage("reading"))
        
    }
    
}
