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
    private let timerQueue: DispatchQueue
    private let delegate: BubbleDelegate
    var updateLabelObserver: ((BubbleObserver) -> Void)?
    private var timer: DispatchSourceTimer?
    private var count: Int = 0

    init(id: String, timerQueue: DispatchQueue, delegate: BubbleDelegate) {
        self.id = id
        self.timerQueue = timerQueue
        self.delegate = delegate
    }

    func startCountdown() {
        timer = DispatchSource.makeTimerSource(queue: timerQueue)
        timer?.schedule(deadline: .now(), repeating: .seconds(1))
        timer?.setEventHandler { [unowned self] in
            if count >= 10 {
                stopTimer()
                delegate.countdownComplete(forBubble: self)
                return
            }
            updateLabelObserver?(.updateBubbleLabel(value: "\(10 - count)"))
            count += 1
        }
        timer?.activate()
    }

    func stopTimer() {
        timer = nil
    }

    func resetTimer() {
        stopTimer()
        count = 0
        startCountdown()
    }

    func getBubbleScore() -> Int {
        11 - count
    }
}
