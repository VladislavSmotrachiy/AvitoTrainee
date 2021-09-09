//
//  EmployeesVC.swift
//  AvitoTrainee
//
//  Created by ErrorV9 on 08.09.2021.
//

import UIKit


class EmployeesVC: UITableViewController {
    
    var avito: Avito?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(from: URLexemples.url.rawValue)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return avito?.company.employees.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return avito?.company.employees[section].name
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.gray
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .center
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let person = avito?.company.employees[indexPath.section]
        var content = cell.defaultContentConfiguration()
        
        switch indexPath.row {
        case 0:
            content.text = person?.phoneNumber
            content.image = UIImage(named: "phone")
        default:
            content.text = person?.skills.joined(separator: ", ")
            content.image = UIImage(named: "skill")
        }
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) {  employee in
            self.avito = employee
            self.title = "Avito кол-во сотрдуников: \(self.avito?.company.employees.count ?? 0)"
            self.tableView.reloadData()
        }
    }
}
