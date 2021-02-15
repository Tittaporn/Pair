//
//  PairRandomController.swift
//  PairRandomizer
//
//  Created by Lee McCormick on 2/12/21.
//

import Foundation

class PairRandomController {
    
    // MARK: - Properties
    static let shared = PairRandomController()
    var sections: [[Person]] = []
    var peopleArray: [Person] = []
    var newPeopleArray: [Person] = []
    
    // MARK: - CRUD Methods
    // CREATE
    func addNewPerson(name: String){
        let newPerson = Person(name: name)
        peopleArray.append(newPerson)
        newPeopleArray.append(newPerson)
        generatePairForEachGroup()
        saveToPersistence()
    }
    
    // UPDATE
    func ramdomPeople() {
        newPeopleArray = []
        peopleArray.shuffle()
        newPeopleArray.append(contentsOf: peopleArray)
        generatePairForEachGroup()
        saveToPersistence()
    }
    
    func generatePairForEachGroup() {
        var newGroup: [Person] = []
        sections = []
        if newPeopleArray.count % 2 != 0 {
            for people in newPeopleArray {
                if newGroup.count < 2 {
                    newGroup.append(people)
                } else {
                    sections.append(newGroup)
                    newGroup = []
                    newGroup.append(people)
                }
            }
            if let people = newPeopleArray.last {
                let lastPerson = [people]
                sections.append(lastPerson)
            }
        } else {
            for people in newPeopleArray {
                if newGroup.count < 2 {
                    newGroup.append(people)
                    if let people = newPeopleArray.last {
                        if newGroup.contains(people) {
                            sections.append(newGroup)
                        }
                    }
                } else {
                    sections.append(newGroup)
                    newGroup = []
                    newGroup.append(people)
                }
            }
        }
    }
    
    // DELETE
    func deletePerson(person: Person) {
        guard let personToDelete = peopleArray.firstIndex(of: person),
              let newPersonToDelete = newPeopleArray.firstIndex(of: person) else {return}
        peopleArray.remove(at: personToDelete)
        newPeopleArray.remove(at: newPersonToDelete)
        ramdomPeople() 
        saveToPersistence()
    }
    
    // MARK: - Persistence
    // CREATE
    func createFileForPersistence() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Person.json")
        return fileURL
    }
    
    // SAVE
    func saveToPersistence() {
        do {
            let data = try JSONEncoder().encode(peopleArray)
            try data.write(to: createFileForPersistence())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    // LOAD
    func loadFromPersistance() {
        do {
            let data = try Data(contentsOf: createFileForPersistence())
            peopleArray = try JSONDecoder().decode([Person].self, from: data)
            newPeopleArray.append(contentsOf: peopleArray)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

