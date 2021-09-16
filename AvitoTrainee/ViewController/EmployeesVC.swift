//
//  EmployeesVC.swift
//  AvitoTrainee
//
//  Created by ErrorV9 on 08.09.2021.
//

import UIKit


class EmployeesVC: UITableViewController {
    
  
    
    private var avito: Avito?
    
    
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
   

   override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
    
        
        let person = avito?.company.employees[indexPath.section]
    
        switch indexPath.row {
        case 0:
            cell.icon.image = UIImage(named: "phone")
            cell.label.text = person?.phoneNumber
            
        default:
            cell.icon.image = UIImage(named: "skill")
            cell.label.text = person?.skills.joined(separator: ", ")
            
        }
 
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
