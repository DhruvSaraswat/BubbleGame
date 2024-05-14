//
//  PersistenceModels.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 14/05/24.
//

import CoreData
import Foundation

struct ScoreObject {
    let score, level: Int64
    let timestamp: Date?
}

extension ScoreObject: ManagedObjectConvertible {
    typealias ManagedObject = Score

    func toManagedObject(in context: NSManagedObjectContext) -> Score? {
        let score = Score(context: context)
        score.level = self.level
        score.score = self.score
        score.timestamp = self.timestamp
        return score
    }
}

extension Score: ManagedObjectProtocol {
    typealias Entity = ScoreObject

    func toEntity() -> ScoreObject? {
        ScoreObject(score: score, level: level, timestamp: timestamp)
    }
}
