//
//  CountdownUtility.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 14/05/24.
//

import Foundation

struct CountdownUtility {
    private static let queue = DispatchQueue(label: "com.timer")

    func executeRepeatedly(forCounts totalCount: Int,
                           currentCount: Int,
                           queue: DispatchQueue?,
                           handler: @escaping (Int) -> Void,
                           countdownCompletion: @escaping () -> Void) {
        guard currentCount < totalCount else {
            countdownCompletion()
            return
        }

        var serialQueue: DispatchQueue = Self.queue
        if let myQueue = queue {
            serialQueue = myQueue
        }
        serialQueue.asyncAfter(deadline: .now() + 1) {
            handler(currentCount)
            executeRepeatedly(forCounts: totalCount,
                              currentCount: currentCount + 1,
                              queue: serialQueue,
                              handler: handler,
                              countdownCompletion: countdownCompletion)
        }
    }
}
