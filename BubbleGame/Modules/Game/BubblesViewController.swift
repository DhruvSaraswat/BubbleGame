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

    private let utility = CountdownUtility()
    private let viewModel = BubblesViewModel()
    private let bubbleTimerQueue = DispatchQueue(label: "com.bubble.timer")
    private let countdownLabelFontSize: CGFloat = 28
    var rate: Int = 1

    private lazy var bubbleWidth: CGFloat = {
        (self.view.window?.windowScene?.screen.bounds.size.width ?? UIScreen.main.bounds.width) / 4
    }()

    private var tapGesture: UITapGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        resetGame()
        viewModel.observer = { [unowned self] state in
            switch state {
            case .showNextScreen(globalRank: let rank):
                debugPrint("RANK = \(String(describing: rank))")
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HighScoresViewController") as! HighScoresViewController
                    vc.rank = rank
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetGame()
        startIntroductoryCountdownTimer()
    }

    private func resetGame() {
        hideIntroductoryCountdownLabel()
        hideCountdownLabel()
        removeTapGestureRecognizer()
    }

    private func startIntroductoryCountdownTimer() {
        utility.executeRepeatedly(forCounts: 6, currentCount: 0, queue: nil,
                                  handler: { [unowned self] currentCount in
            DispatchQueue.main.async {
                UIView.transition(with: self.introductoryCountdownLabel,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: { [unowned self] in
                    introductoryCountdownLabel.text = "The game starts in \(5 - currentCount) ..."
                    if introductoryCountdownLabel.isHidden {
                        showIntroductoryCountdownLabel()
                    }
                })
            }
        }, countdownCompletion: { [unowned self] in
            hideIntroductoryCountdownLabel()
            showCountdownLabel()
            addTapGestureRecognizer()
            startGameTimer()
        })
    }

    private func startGameTimer() {
        utility.executeRepeatedly(forCounts: 31, currentCount: 0, queue: nil,
                                  handler: {  [unowned self] currentCount in
            DispatchQueue.main.async {
                UIView.transition(with: self.countdownLabel,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: { [unowned self] in
                    countdownLabel.text = "\(30 - currentCount)"
                    if countdownLabel.isHidden {
                        showCountdownLabel()
                    }
                    if currentCount >= 25 {
                        highlightCountdownLabel()
                    }
                })
            }
        }, countdownCompletion: { [unowned self] in
            removeTapGestureRecognizer()
            processScoreAndRemoveAllBubbles()
        })
    }

    private func showIntroductoryCountdownLabel() {
        DispatchQueue.main.async { [unowned self] in
            introductoryCountdownLabel.isHidden = false
        }
    }

    private func hideIntroductoryCountdownLabel() {
        DispatchQueue.main.async { [unowned self] in
            introductoryCountdownLabel.isHidden = true
        }
    }

    private func showCountdownLabel() {
        DispatchQueue.main.async { [unowned self] in
            countdownLabel.font = .systemFont(ofSize: countdownLabelFontSize)
            countdownLabel.textColor = .black
            countdownLabel.isHidden = false
        }
    }

    private func highlightCountdownLabel() {
        DispatchQueue.main.async { [unowned self] in
            countdownLabel.font = .systemFont(ofSize: countdownLabelFontSize, weight: .bold)
            countdownLabel.textColor = .red
        }
    }

    private func hideCountdownLabel() {
        DispatchQueue.main.async { [unowned self] in
            countdownLabel.isHidden = true
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

    private func processScoreAndRemoveAllBubbles() {
        let score = viewModel.getTotalScore()
        viewModel.removeAllBubbles()
        viewModel.persistScoreDetails(score: score, level: rate)
        Task {
            await viewModel.sendScoreToServer(score: score)
        }
    }

    @objc private func createBubble(_ touch: UITapGestureRecognizer) {
        let touchPoint = touch.location(in: view)
        let xCenter = touchPoint.x - (bubbleWidth / 2)
        let yCenter = touchPoint.y - (bubbleWidth / 2)

        let bubble = BubbleView(frame: CGRect(x: xCenter, y: yCenter, width: bubbleWidth, height: bubbleWidth))
        let id = UUID().uuidString
        let bubbleViewModel = BubbleViewModel(id: id, timerQueue: bubbleTimerQueue, delegate: self, countdownRate: rate)
        bubble.viewModel = bubbleViewModel
        bubble.setupObserver()
        viewModel.addBubble(withViewModel: bubbleViewModel, view: bubble)
        bubbleViewModel.startCountdown()
        view.addSubview(bubble)
    }
}

extension BubblesViewController: BubbleDelegate {
    func countdownComplete(forBubble vm: BubbleViewModel) {
        viewModel.removeBubble(withViewModel: vm)
    }
}
