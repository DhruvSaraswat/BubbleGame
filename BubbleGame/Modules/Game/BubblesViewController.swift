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
        executeRepeatedly(forCounts: 5, currentCount: 0) { [unowned self] currentCount in
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
        }
    }

    private func executeRepeatedly(forCounts totalCount: Int, currentCount: Int, handler: @escaping (Int) -> Void) {
        guard currentCount < totalCount else {
            hideIntroductoryCountdownLabel()
            showCountdownLabel()
            return
        }

        queue.asyncAfter(deadline: .now() + 1) { [weak self] in
            handler(currentCount)
            self?.executeRepeatedly(forCounts: totalCount, currentCount: currentCount + 1, handler: handler)
        }
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
