//
//  Utility.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 14/05/24.
//

import Foundation

struct Utility {
    func executeRepeatedly(forCounts totalCount: Int,
                           currentCount: Int,
                           queue: DispatchQueue,
                           handler: @escaping (Int) -> Void,
                           countdownCompletion: @escaping () -> Void) {
        guard currentCount < totalCount else {
            countdownCompletion()
            return
        }

        queue.asyncAfter(deadline: .now() + 1) {
            handler(currentCount)
            executeRepeatedly(forCounts: totalCount,
                              currentCount: currentCount + 1,
                              queue: queue,
                              handler: handler,
                              countdownCompletion: countdownCompletion)
        }
    }
}
