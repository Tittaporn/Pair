//
//  PairRandom.swift
//  PairRandomizer
//
//  Created by Lee McCormick on 2/12/21.
//

import Foundation

class Person: Codable {
    var name: String
    init(name: String) {
        self.name = name
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}

class PairRandom: Codable {
    var people: [Person]
    init(people: [Person]) {
        self.people = people
    }
}

extension PairRandom: Equatable {
    static func == (lhs: PairRandom, rhs: PairRandom) -> Bool {
        return lhs.people == rhs.people
    }
}
