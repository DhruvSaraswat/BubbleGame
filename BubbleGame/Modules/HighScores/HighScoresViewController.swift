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

    var rank: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        globalRankLabel.text = "Global Rank - \(rank ?? "N/A")"
    }

    @IBAction func handlePlayAgainButtonTap(_ sender: Any) {
        dismiss(animated: false)
    }

}
