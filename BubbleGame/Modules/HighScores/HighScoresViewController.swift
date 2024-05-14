//
//  HighScoresViewController.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 15/05/24.
//

import UIKit

final class HighScoresViewController: UIViewController {

    @IBOutlet private weak var globalRankLabel: UILabel!
    @IBOutlet private weak var highScoresInfoLabel: UILabel!

    private let viewModel = HighScoresViewModel()

    var rank: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.observer = { [unowned self] state in
            switch state {
            case .updateHighScores(highScores: let highScore):
                DispatchQueue.main.async { [unowned self] in
                    highScoresInfoLabel.text = highScore
                }
            }
        }
        viewModel.fetchHighScores()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        globalRankLabel.text = "Global Rank - \(rank ?? "N/A")"
    }

    @IBAction func handlePlayAgainButtonTap(_ sender: Any) {
        dismiss(animated: false)
    }

}
