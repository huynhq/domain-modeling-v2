//
//  main.swift
//  SimpleDomainModel
//
//  Created by Quynh Huynh
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

public class TestMe {
    public func Please() -> String {
        return "I have been tested"
    }
}

////////////////////////////////////
// Money
//
public struct Money {
    public var amount : Double
    public var currency : String
    // Conversion Rates
    // 1 USD = .5 GBP (2 USD = 1 GBP)
    // 1 USD = 1.5 EUR (2 USD = 3 EUR)
    // 1 USD = 1.25 CAN (4 USD = 5 CAN)
    
    let USD = [
        "GBP" : 0.5,
        "EUR" : 1.5,
        "CAN" : 1.25
    ]
    
    let GBP = [
        "USD" : 2.0,
        "EUR" : 3.0,
        "CAN" : 2.5
    ]
    let EUR = [
        "USD" : 0.6666667,
        "GBP" : 0.3333,
        "CAN" : 0.83333
    ]
    let CAN = [
        "USD" : 0.8,
        "GBP" : 0.4,
        "EUR" : 0.6
    ]
    
    public func convert(to: String) -> Money {
        var conversion = 1.0;
        if(currency != to) {
            if(currency == "USD") {
                conversion = USD[to]!
            } else if(currency == "GBP") {
                conversion = GBP[to]!
            } else if(currency == "EUR") {
                conversion = EUR[to]!
            } else if(currency == "CAN") {
                conversion = CAN[to]!
            }
        }
        let result = Money(amount: round(amount * conversion), currency: to)
        return result
    }
    
    public func add(to: Money) -> Money {
        let new = convert(to.currency)
        return Money(amount: new.amount + to.amount, currency: to.currency)
    }
    public func subtract(from: Money) -> Money {
        let new = convert(from.currency)
        return Money(amount: new.amount - from.amount, currency: from.currency)
    }
}

////////////////////////////////////
// Job
//
public class Job {
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public var title : String
    public var type : JobType
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    public func calculateIncome(hours: Int) -> Int {
        var income = 0
        switch type {
            case .Hourly(let hourlyRate): income = Int(Double(hours) * hourlyRate)
            case .Salary(let yearlyRate): income = yearlyRate
        }
        return income
    }
    
    public func raise(amt : Double) {
        switch type {
            case .Hourly(let hourlyRate): type = JobType.Hourly(hourlyRate + amt)
            case .Salary(let yearlyRate): type = JobType.Salary(yearlyRate + Int(amt))
        }
    }
}

////////////////////////////////////
// Person
//
public class Person {
    public var firstName : String = ""
    public var lastName : String = ""
    public var age : Int = 0
    public var _job : Job?
    public var _spouse : Person?
    
    public var job : Job? {
        get {
            return _job
        } set(value) {
            if(age >= 16) {
                _job = value!
            } else {
                _job = nil
            }
        }
    }
    
    public var spouse : Person? {
        get {
            return _spouse
        } set(value) {
            if(age >= 18) {
                _spouse = value!
            } else {
                _spouse = nil
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    public func toString() -> String {
        //[Person: firstName:Ted lastName:Neward age:45 job:nil spouse:nil]
        let name = "[Person: firstName:\(firstName) lastName:\(lastName)"
        let info = " age:\(age) job:nil spouse:nil]"
        return name + info
    }
}

////////////////////////////////////
// Family
//
public class Family {
    private var members : [Person] = []
    
    public init(spouse1: Person, spouse2: Person) {
        if(spouse1._spouse == nil && spouse2._spouse == nil) {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            members.append(spouse1)
            members.append(spouse2)
        }
    }
    
    public func haveChild(child: Person) -> Bool {
        var valid = false
        for person in members {
            if(person.age > 21) {
                valid = true
            }
        }
        if(valid) {
            members.append(child)
        }
        return valid
    }
    
    public func householdIncome() -> Int {
        var income = 0
        for person in members {
            if(person.job != nil) {
                income += (person.job?.calculateIncome(2000))!
            }
        }
        return income
    }
}



