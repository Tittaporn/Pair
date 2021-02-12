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
    
    // MARK: - CRUD Methods
    // CREATE
    func addNewPerson(name: String){
            let newPerson = Person(name: name)
            peopleArray.append(newPerson)
            ramdomPeople()
            saveToPersistence()
        }

    
    // UPDATE
    func ramdomPeople() {
          peopleArray.shuffle()
          saveToPersistence()
      }
    
    // DELETE
    func deletePerson(person: Person) {
          guard let personToDelete = peopleArray.firstIndex(of: person) else {return}
          peopleArray.remove(at: personToDelete)
          saveToPersistence()
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

/* NOTE Continue to work on sections per group
 

  //    func generateSection() {
  //
  //    let numberOfsections = (peopleArray.count / 2) +
  //                (peopleArray.count % 2)
  //
  //        print("numberOfsections\(numberOfsections)")
  //
  //        for section in 0...numberOfsections {
  //            //var sections: [PairRandom] = []
  //
  //            var indexForPeopleArray = numberOfsections - 1
  //            let firstPerson = Person(name: peopleArray[indexForPeopleArray].name)
  //            indexForPeopleArray += 1
  //            let secondPerson = Person(name: peopleArray[indexForPeopleArray].name)
  //
  //            let newRandomPair = [firstPerson,secondPerson]
  //
  //
  //            sections.append(newRandomPair)
  //            print("section :: \(section)")
  //            indexForPeopleArray += 1
  //        }
  
  // now 6 sections
  // each section need 2 person from people Array
  //        for person in peopleArray {
  //
  //        }
  //
  
  //  }
  
 //______________________________________________________________________________________
 
 */
