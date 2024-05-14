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
        globalRankLabel.text = rank ?? "N/A"
    }

    @IBAction func handlePlayAgainButtonTap(_ sender: Any) {
        dismiss(animated: true)
    }

}
