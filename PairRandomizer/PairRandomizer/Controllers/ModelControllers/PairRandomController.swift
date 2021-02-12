//
//  PairRandomController.swift
//  PairRandomizer
//
//  Created by Lee McCormick on 2/12/21.
//

import Foundation

class PairRandomController {
    static let shared = PairRandomController()
    var sections: [PairRandom] = []
    var peopleArray: [Person] = []
    
    func addNewPerson(name: String){
        let newPerson = Person(name: name)
        peopleArray.append(newPerson)
    }
    
    func ramdomPeople() {
//        var numberOfsections = (peopleArray.count / 2) +
//        (peopleArray.count % 2)
//
//        for section in 0...numberOfsections {
//
//        }
        
        peopleArray.shuffle()
    }
    
    func deletePerson(person: Person) {
        guard let personToDelete = peopleArray.firstIndex(of: person) else {return}
        peopleArray.remove(at: personToDelete)
    }
    
    
    // MARK: - Persistence
    // CREATE
    func createFileForPersistence() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Person.json") //Need to Change FileName
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
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
