//
//  BubbleViewModel.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 14/05/24.
//

import Foundation

enum BubbleObserver {
    case updateBubbleLabel(value: String)
}

protocol BubbleDelegate {
    func countdownComplete(forBubble vm: BubbleViewModel)
}

final class BubbleViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: BubbleViewModel, rhs: BubbleViewModel) -> Bool {
        lhs.id.elementsEqual(rhs.id)
    }
    
    private let id: String
    private let utility: Utility
    private let delegate: BubbleDelegate
    var updateLabelObserver: ((BubbleObserver) -> Void)?

    init(id: String, utility: Utility = Utility(), delegate: BubbleDelegate) {
        self.id = id
        self.utility = utility
        self.delegate = delegate
    }

    func startCountdown() {
        utility.executeRepeatedly(forCounts: 11, currentCount: 0, queue: nil,
                                  handler: { [unowned self] currentCount in
            self.updateLabelObserver?(.updateBubbleLabel(value: "\(10 - currentCount)"))
        }, countdownCompletion: { [unowned self] in
            self.delegate.countdownComplete(forBubble: self)
        })
    }
}
