//
//  BubblesViewModel.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 14/05/24.
//

import Foundation

final class BubblesViewModel {
    private var bubblesOnScreen: [BubbleViewModel: BubbleView] = [:]

    func addBubble(withViewModel vm: BubbleViewModel, view: BubbleView) {
        bubblesOnScreen[vm] = view
    }

    func removeBubble(withViewModel vm: BubbleViewModel) {
        if let bubbleToBeRemoved = getBubbleView(withViewModel: vm) {
            DispatchQueue.main.async {
                bubbleToBeRemoved.removeFromSuperview()
            }
        }
        bubblesOnScreen[vm] = nil
    }

    func removeAllBubbles() {
        for bubble in bubblesOnScreen {
            removeBubble(withViewModel: bubble.key)
        }
    }

    func getBubbleView(withViewModel vm: BubbleViewModel) -> BubbleView? {
        bubblesOnScreen[vm]
    }

    func getTotalScore() -> Int {
        var score: Int = 0
        for bubbleViewModel in bubblesOnScreen {
            score += bubbleViewModel.key.getBubbleScore()
        }
        return score
    }
}
