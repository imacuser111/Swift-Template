//
//  SKSTrinstain.swift
//  NewTalk
//
//  Created by user on 2020/10/29.
//

import Foundation
import UIKit

class WKPresentTransition:NSObject, UIViewControllerAnimatedTransitioning {
    
    // 定義轉場動畫為0.8秒
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    // 具體的轉場動畫
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromView = fromVC?.view
        
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC?.view
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView!)
        toView!.frame.origin = CGPoint(x: toView!.frame.width, y: 0)
        
        // 轉場動畫
        toView?.frame = CGRect(x: fromView?.frame.width ?? 0, y: 0, width: fromView?.frame.width ?? 0, height: fromView?.frame.height ?? 0)
        UIView.animate(withDuration: 0.4, animations: {
            toView?.frame = fromView?.frame ?? CGRect.zero;
            fromView?.frame = (fromView?.frame ?? CGRect.zero).offsetBy(dx: -(fromView?.frame.width ?? 0), dy: 0);
        }, completion: { finished in
            UIView.animate(withDuration: 0.4, animations: {
                toView?.frame = CGRect(x: 0, y: 0, width: fromView?.frame.width ?? 0, height: fromView?.frame.height ?? 0)
                fromView?.frame = CGRect(x: 0, y: 0, width: fromView?.frame.width ?? 0, height: fromView?.frame.height ?? 0)
            }, completion: { finished in
                // 通知完成轉場
                transitionContext.completeTransition(true)
            })
            
        })
    }
}


class WKDismissPresentTransition:NSObject, UIViewControllerAnimatedTransitioning {
    
    // 定義轉場動畫為0.8秒
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    // 具體的轉場動畫
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromView = fromVC?.view
        
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC?.view
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromView!)
        fromView!.frame.origin = .zero
        
        // 轉場動畫
        toView?.frame = CGRect(x: -(fromView?.frame.width ?? 0), y: 0, width: fromView?.frame.width ?? 0, height: fromView?.frame.height ?? 0)
        UIView.animate(withDuration: 0.4, animations: {
            toView?.frame = fromView?.frame ?? CGRect.zero;
            fromView?.frame = (fromView?.frame ?? CGRect.zero).offsetBy(dx: (fromView?.frame.width ?? 0), dy: 0);
        }, completion: { finished in
            UIView.animate(withDuration: 0.4, animations: {
                fromView!.removeFromSuperview()
                toView?.frame = CGRect(x: 0, y: 0, width: fromView?.frame.width ?? 0, height: fromView?.frame.height ?? 0)
            }, completion: { finished in
                // 通知完成轉場
                toVC?.view.layoutIfNeeded()
                transitionContext.completeTransition(true)
            })
            
        })
            
        
    }
}
