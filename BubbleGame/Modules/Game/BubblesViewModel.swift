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
        bubblesOnScreen[vm] = nil
    }

    func getBubbleView(withViewModel vm: BubbleViewModel) -> BubbleView? {
        bubblesOnScreen[vm]
    }
}
