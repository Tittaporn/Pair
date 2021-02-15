//
//  PairRandomizerTableListViewController.swift
//  PairRandomizer
//
//  Created by Lee McCormick on 2/12/21.
//

import UIKit

class PairRandomizerTableListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var randomizerButton: UIButton!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        randomizerButton.layer.cornerRadius = 10.0
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PairRandomController.shared.loadFromPersistance()
        PairRandomController.shared.generatePairForEachGroup()
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        presentAlertToAddNewPerson()
    }
    
    @IBAction func randomnizeButtonTapped(_ sender: Any) {
        PairRandomController.shared.loadFromPersistance()
        PairRandomController.shared.ramdomPeople()
        tableView.reloadData()
    }
    
    // MARK: - Helper Fuctions
    func presentAlertToAddNewPerson() {
        let alertController = UIAlertController(title: "Add Person", message: "Add someone new to the list.", preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Type new person' name here..."
        }
        
        let addNewPersonAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let text = alertController.textFields?[0].text, !text.isEmpty else {return}
            PairRandomController.shared.addNewPerson(name: text)
            self.tableView.reloadData()
        }
        
        let cancleAction = UIAlertAction(title: "cancel", style: .cancel)
        alertController.addAction(cancleAction)
        alertController.addAction(addNewPersonAction)
        present(alertController, animated: true)
    }
}

// MARK: - Extensions
extension PairRandomizerTableListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return PairRandomController.shared.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PairRandomController.shared.sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "personRandomCell", for: indexPath)
        let personInCell = PairRandomController.shared.sections[indexPath.section][indexPath.row]
        cell.textLabel?.text = personInCell.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let personToDelete = PairRandomController.shared.sections[indexPath.section][indexPath.row]
            PairRandomController.shared.deletePerson(person: personToDelete)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40.0)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.systemOrange
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.brown
        header.textLabel?.font = UIFont(name: "Apple Color Emoji", size: 18)
    }
}

