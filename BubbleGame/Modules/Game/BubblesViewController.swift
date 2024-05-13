//
//  BubblesViewController.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 14/05/24.
//

import UIKit

final class BubblesViewController: UIViewController {
    @IBOutlet private weak var countdownLabel: UILabel!
    @IBOutlet private weak var introductoryCountdownLabel: UILabel!

    private let queue = DispatchQueue(label: "com.timer")
    private let utility = Utility()

    override func viewDidLoad() {
        super.viewDidLoad()
        hideIntroductoryCountdownLabel()
        hideCountdownLabel()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        startIntroductoryCountdownTimer()
    }

    private func startIntroductoryCountdownTimer() {
        utility.executeRepeatedly(forCounts: 6, currentCount: 0, queue: queue,
                                  handler: { [unowned self] currentCount in
            DispatchQueue.main.async {
                UIView.transition(with: self.introductoryCountdownLabel,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: { [unowned self] in
                    self.introductoryCountdownLabel.text = "The game starts in \(5 - currentCount) ..."
                    if self.introductoryCountdownLabel.isHidden {
                        showIntroductoryCountdownLabel()
                    }
                })
            }
        }, countdownCompletion: { [unowned self] in
            self.hideIntroductoryCountdownLabel()
            self.showCountdownLabel()
        })
    }

    private func showIntroductoryCountdownLabel() {
        DispatchQueue.main.async { [unowned self] in
            self.introductoryCountdownLabel.isHidden = false
        }
    }

    private func hideIntroductoryCountdownLabel() {
        DispatchQueue.main.async { [unowned self] in
            self.introductoryCountdownLabel.isHidden = true
        }
    }

    private func showCountdownLabel() {
        DispatchQueue.main.async { [unowned self] in
            self.countdownLabel.isHidden = false
        }
    }

    private func hideCountdownLabel() {
        DispatchQueue.main.async { [unowned self] in
            self.countdownLabel.isHidden = true
        }
    }
}
