//
//  PresentAnimation.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 13/05/24.
//

import Foundation
import UIKit

final class PresentAnimation: NSObject {
    private var animator: UIViewImplicitlyAnimating?
}

extension PresentAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        0.3
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        animator = interruptibleAnimator(using: transitionContext)
        animator?.startAnimation()
    }

    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if animator != nil {
            return animator!
        }

        let container = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: .from)!

        let fromViewInitialFrame = transitionContext.initialFrame(for: fromVC)
        var fromViewFinalFrame = fromViewInitialFrame
        fromViewFinalFrame.origin.x = -fromViewFinalFrame.width

        let fromView = fromVC.view!
        let toView = transitionContext.view(forKey: .to)!

        var toViewInitialFrame = fromViewInitialFrame
        toViewInitialFrame.origin.x = toView.frame.size.width

        toView.frame = toViewInitialFrame
        container.addSubview(toView)

        let customAnimator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), curve: .easeInOut) {
            toView.frame = fromViewInitialFrame
            fromView.frame = fromViewFinalFrame
        }

        customAnimator.addCompletion { _ in
            transitionContext.completeTransition(true)
        }

        animator = customAnimator
        return animator!
    }

    func animationEnded(_ transitionCompleted: Bool) {
        animator = nil
    }
}
