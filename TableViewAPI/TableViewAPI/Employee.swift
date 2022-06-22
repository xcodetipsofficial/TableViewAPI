//
//  Employee.swift
//  TableViewAPI
//
//  Created by Kyle Wilson on 2022-06-21.
//

import Foundation
import UIKit

struct Employee: Codable {
    var empid: String
    var name: String
    var email: String
    var designation: String
    var address: Address
    var gender: String
    var phone: Phone
    var office: String
}

struct Phone: Codable {
    var mobile: String
    var home: String
}

struct Address: Codable {
    var country: String
    var province: String
    var streetaddress: String
    var postalcode: String
}

struct ResponseData: Decodable {
    var employees: [Employee]
}

struct BasicEmployeeModel { //used for VM
    var image: UIImage
    var name: String
}

struct Person {
    let employee: Employee
    let employeeImage: UIImage
}

struct Section {
    let letter: String
    let people: [Person]
}
