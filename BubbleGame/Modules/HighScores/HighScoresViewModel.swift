//
//  HighScoresViewModel.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 15/05/24.
//

import Foundation

enum HighScoresViewState {
    case updateHighScores(highScores: String)
}

final class HighScoresViewModel {
    private let coreDataWorker: CoreDataWorker? = CoreDataWorker<Score, ScoreObject>()

    var observer: ((HighScoresViewState) -> Void)?

    func fetchHighScores() {
        let predicate = NSPredicate(format: "score != nil")
        let descriptor = NSSortDescriptor(key: "score", ascending: false)
        let fetchLimit = 5 /// Get the top 5 scores
        coreDataWorker?.fetch(predicate, [descriptor], fetchLimit) { [unowned self] result in
            switch result {
            case .success(let scores):
                var highScores: String = ""
                for score in scores {
                    let scoreString = "Score - \(score.score)\nLevel - \(score.level)\nDate - \(String(describing: score.timestamp))\n\n"
                    highScores.append(scoreString)
                }
                observer?(.updateHighScores(highScores: highScores))

            case .failure(let error):
                debugPrint("error occurred while fetching high scores - \(error)")
            }
        }
    }
}
