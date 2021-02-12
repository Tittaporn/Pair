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
    
    // MARK: - Properties
    var peopleArray = ["one", "two", "three", "four", "five", "six", "seven", "eight","nine", "ten","eleven"]
    var newPeopleArray: [String] = []
    var groupArray: [String] = []
    var sections: [[group]] = []
    var groupArrayTest = [["one", "two"], ["three", "four"], ["five", "six"],[ "seven", "eight"],["nine", "ten"],["eleven"]]
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        PairRandomController.shared.loadFromPersistance()
        tableView.reloadData()
        
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        presentAlertToAddNewPerson()
    }
    
    
    @IBAction func randomnizeButtonTapped(_ sender: Any) {
        //newPeopleArray = peopleArray.shuffled()
        PairRandomController.shared.loadFromPersistance()

        PairRandomController.shared.ramdomPeople()
        
        tableView.reloadData()
        
    }
    
    // MARK: - Helper Fuctions
    func createdGroupSection() {
        //var
    }
    
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
            return 1 //PairRandomController.shared.peopleArray.count
                // groupArray.count
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PairRandomController.shared.peopleArray.count
            //newPeopleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "personRandomCell", for: indexPath)
        
        let personInCell = PairRandomController.shared.peopleArray[indexPath.row]
            //newPeopleArray[indexPath.row]
        
        //groupArrayTest[indexPath.section][indexPath.row]
        cell.textLabel?.text = personInCell.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let personToDelete = PairRandomController.shared.peopleArray[indexPath.row]
            PairRandomController.shared.deletePerson(person: personToDelete)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group"
    }
    
    
}


