//
//  EmployeeCell.swift
//  TableViewAPI
//
//  Created by Kyle Wilson on 2022-06-21.
//

import UIKit

class EmployeeCell: UITableViewCell {
    
    @IBOutlet weak var employeeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with viewModel: BasicEmployeeModel) { //used for VM
        employeeImage.image = viewModel.image
        nameLabel.text = viewModel.name
    }
    
}
