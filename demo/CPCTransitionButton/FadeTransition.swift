//
//  SpinerLayer.swift
//  swiftTEST
//
//  Created by 鹏程 on 17/8/3.
//  Copyright © 2017年 CPC-Coder. All rights reserved.
//

import UIKit


open class FadeInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var transitionDuration: TimeInterval = 0.5
    var startingAlpha: CGFloat = 0.0

    public convenience init(transitionDuration: TimeInterval, startingAlpha: CGFloat){
        self.init()
        self.transitionDuration = transitionDuration
        self.startingAlpha = startingAlpha
    }

    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        //源vc
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)! as UIViewController
        //目标vc
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)! as UIViewController
        let initalFrame = transitionContext.initialFrame(for: fromVC)
        toVC.view.frame = initalFrame
        fromVC.view.frame = initalFrame
        
        


        toVC.view.alpha = startingAlpha
        fromVC.view.alpha = 0.8
        
        containerView.addSubview(toVC.view)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { () -> Void in
            
            toVC.view.alpha = 1.0
            fromVC.view.alpha = 0.0
            
            }, completion: {
                _ in
                fromVC.view.alpha = 1.0
                transitionContext.completeTransition(true)
        })
    }
}
