//
//  JobTests.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

import SimpleDomainModel

class JobTests: XCTestCase {
    
    func testCreateSalaryJob() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.calculateIncome(50) == 1000)
    }
    
    func testCreateHourlyJob() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.calculateIncome(10) == 150)
    }
    
    func testSalariedRaise() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.calculateIncome(50) == 1000)
        
        job.raise(1000)
        XCTAssert(job.calculateIncome(50) == 2000)
    }
    
    func testHourlyRaise() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.calculateIncome(10) == 150)
        
        job.raise(1.0)
        XCTAssert(job.calculateIncome(10) == 160)
    }
    
    func testCustomStringConvertibleSalary() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        let result = job.description
        XCTAssert(result == "Guest Lecturer Salary(1000)")
    }
    
    func testCustomStringConvertibleHourly() {
        let job = Job(title: "Loan Shark", type: Job.JobType.Hourly(5000))
        let result = job.description
        print(result)
        XCTAssert(result == "Loan Shark Hourly(5000.0)")
    }
    
}
