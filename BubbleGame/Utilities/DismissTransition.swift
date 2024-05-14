//
//  DismissTransition.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 15/05/24.
//

import Foundation
import UIKit

final class DismissTransition: NSObject {
    private var animator: UIViewImplicitlyAnimating?
}

extension DismissTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        Constants.transitionDuration
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        animator = interruptibleAnimator(using: transitionContext)
        animator?.startAnimation()
    }
    
    func interruptibleAnimator(using transitionContext: any UIViewControllerContextTransitioning) -> any UIViewImplicitlyAnimating {
        if self.animator != nil {
            return self.animator!
        }

        let fromVC = transitionContext.viewController(forKey: .from)!
        var fromViewInitialFrame = transitionContext.initialFrame(for: fromVC)
        fromViewInitialFrame.origin.x = 0
        var fromViewFinalFrame = fromViewInitialFrame
        fromViewFinalFrame.origin.x = fromViewFinalFrame.width

        let fromView = fromVC.view!
        let toView = transitionContext.viewController(forKey: .to)!.view!

        var toViewInitialFrame = fromViewInitialFrame
        toViewInitialFrame.origin.x = -toView.frame.size.width

        toView.frame = toViewInitialFrame

        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), curve: .easeInOut) {
            toView.frame = fromViewInitialFrame
            fromView.frame = fromViewFinalFrame
        }

        animator.addCompletion { _ in
            transitionContext.completeTransition(true)
        }

        self.animator = animator
        return animator
    }

    func animationEnded(_ transitionCompleted: Bool) {
        animator = nil
    }
}
