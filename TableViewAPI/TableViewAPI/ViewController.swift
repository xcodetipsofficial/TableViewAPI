//
//  ViewController.swift
//  TableViewAPI
//
//  Created by Kyle Wilson on 2022-06-21.
//

import UIKit

class ViewController: UIViewController {
    
    var employees = [Employee]()
    var tableView: UITableView!
    var humanImages = [
        UIImage(named: "barbrastreisand")!,
        UIImage(named: "kevinsherwood")!,
        UIImage(named: "elenasiegman")!,
        UIImage(named: "markokubo")!,
        UIImage(named: "synystergates")!,
    ]
    
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = constructURL()
        getEmployeeData(url: url)
        tableView = UITableView(frame: CGRect(origin: .zero, size: view.frame.size))
        tableView.register(UINib(nibName: "EmployeeCell", bundle: nil), forCellReuseIdentifier: "employeecell")
        tableView.rowHeight = 82
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    func constructURL() -> URL {
        var url = URLComponents()
        url.host = Constants().host
        url.scheme = Constants().scheme
        url.path = Constants().path
        return url.url!
    }
    
    func getEmployeeData(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data {
                    do {
                        let employees = try JSONDecoder().decode(ResponseData.self, from: data)
                        self.employees = employees.employees
                        print(self.employees)
                        DispatchQueue.main.async {
                            var people = [Person]()
                            //group each employee with an image
                            for (index, employee) in employees.employees.enumerated() {
                                let person = Person(employee: employee, employeeImage: self.humanImages[index])
                                people.append(person)
                            }
                            //convert into dictionary
                            let groupedDictionary = Dictionary(grouping: people, by: { String($0.employee.name.prefix(1)) })
                            //sort the dictionary and create sections
                            let sortedPeople = groupedDictionary.sorted(by: { $0.0 < $1.0 })
                            for (key, value) in sortedPeople {
                                self.sections.append(Section(letter: key, people: value))
                            }
                            self.tableView.reloadData()
                        }
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
        }
        task.resume()
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeecell") as! EmployeeCell
        let section = sections[indexPath.section]
        let image = section.people[indexPath.row].employeeImage
        let name = section.people[indexPath.row].employee.name
        let employeeModel = BasicEmployeeModel(image: image, name: name)
        cell.configure(with: employeeModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let moveToNextVC = storyboard?.instantiateViewController(withIdentifier: "detailviewcontroller") as! DetailViewController
        let section = sections[indexPath.section]
        moveToNextVC.employee = section.people[indexPath.row].employee
        moveToNextVC.employeeImage = section.people[indexPath.row].employeeImage
        self.present(moveToNextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].letter
    }
    
}
