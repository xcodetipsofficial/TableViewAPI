//
//  DetailViewController.swift
//  TableViewAPI
//
//  Created by Kyle Wilson on 2022-06-21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var employee: Employee!
    var employeeImage: UIImage!
    
    @IBOutlet weak var employeeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var empidLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var homeNumLabel: UILabel!
    @IBOutlet weak var mobileNumLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("new view")
        view.backgroundColor = .white.withAlphaComponent(0.9)
        setEmployeeData()
    }
    
    func setEmployeeData() {
        nameLabel.text = employee.name
        designationLabel.text = "Position: \(employee.designation)"
        employeeImageView.image = employeeImage
        empidLabel.text = "ID: \(employee.empid)"
        emailLabel.text = "Email: \(employee.email)"
        homeNumLabel.text = "Home #: \(employee.phone.home)"
        mobileNumLabel.text = "Mobile #: \(employee.phone.mobile)"
        addressLabel.text = "Address:\n\(employee.address.streetaddress). \(employee.address.postalcode)\n\(employee.address.country), \(employee.address.province)"
    }
}
