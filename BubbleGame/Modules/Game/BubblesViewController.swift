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

    private lazy var bubbleWidth: CGFloat = {
        (self.view.window?.windowScene?.screen.bounds.size.width ?? UIScreen.main.bounds.width) / 4
    }()

    private var tapGesture: UITapGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        hideIntroductoryCountdownLabel()
        hideCountdownLabel()
        removeTapGestureRecognizer()
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
            self.addTapGestureRecognizer()
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

    private func addTapGestureRecognizer() {
        DispatchQueue.main.async { [unowned self] in
            let gesture = UITapGestureRecognizer(target: self, action: #selector(createBubble))
            tapGesture = gesture
            view.addGestureRecognizer(gesture)
        }
    }

    private func removeTapGestureRecognizer() {
        DispatchQueue.main.async { [unowned self] in
            if let tapGesture {
                view.removeGestureRecognizer(tapGesture)
            }
        }
    }

    @objc private func createBubble(_ touch: UITapGestureRecognizer) {
        let touchPoint = touch.location(in: view)
        var xCenter = touchPoint.x - (bubbleWidth / 2)
        var yCenter = touchPoint.y - (bubbleWidth / 2)

        /**if xCenter < (bubbleWidth / 2) {
            /// some part of the left side of the bubble will be outside the screen's edge,
            /// so shift the bubble center a little to the right so that the entire bubble is visible
            xCenter = (bubbleWidth / 2) + 5
        }

        if xCenter > (UIScreen.main.bounds.width - (bubbleWidth / 2)) {
            /// some part of the right side of the bubble will be outside the screen's edge,
            /// so shift the bubble center a little to the left so that the entire bubble is visible
            xCenter = (UIScreen.main.bounds.width - (bubbleWidth / 2)) - 5
        }

        if yCenter < (bubbleWidth / 2) {
            /// some part of the top side of the bubble will be outside the screen's edge,
            /// so shift the bubble center a little down so that the entire bubble is visible
            yCenter = (bubbleWidth / 2) + 5
        }

        if yCenter > (UIScreen.main.bounds.height - (bubbleWidth / 2)) {
            /// some part of the down side of the bubble will be outside the screen's edge,
            /// so shift the bubble center a little up so that the entire bubble is visible
            yCenter = (UIScreen.main.bounds.height - (bubbleWidth / 2)) - 5
        }*/

        let bubble = Bubble(frame: CGRect(x: xCenter, y: yCenter, width: bubbleWidth, height: bubbleWidth))
        view.addSubview(bubble)
    }
}
