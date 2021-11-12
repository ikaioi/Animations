//
//  TransitionDelegate.swift
//  AnimatedList
//
//  Created by Kaio Dantas on 12/11/2021.
//

import UIKit

protocol AnimatedViewController {
    func zoomingImageView(for transition: TransitionDelegate) -> UIImageView?
    func zoomingBackgroundView(for transition: TransitionDelegate) -> UIView?
    func zoomingTextsView(for transition: TransitionDelegate) -> UIView?
    func slidingTextView(for transition: TransitionDelegate) -> UIView?
}


enum TransitionState {
    case initial
    case final
}

class TransitionDelegate: NSObject, UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning {
    
    let transitionDuration = 1.0
    var operation: UINavigationController.Operation = .none

    
    //MARK: - UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if fromVC is AnimatedViewController && toVC is AnimatedViewController {
            self.operation = operation
            return self
        } else {
            return nil
        }
        
    }
    
    
    //MARK: - UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let duration = transitionDuration(using: transitionContext)
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        let containerView = transitionContext.containerView
        
        var backgroundViewController = fromViewController
        var foregroundViewController = toViewController
        
        if operation == .pop {
            backgroundViewController = toViewController
            foregroundViewController = fromViewController
        }
        
        if let backgroundImageView = (backgroundViewController as? AnimatedViewController)?.zoomingImageView(for: self),
           let foregroundImageView = (foregroundViewController as? AnimatedViewController)?.zoomingImageView(for: self),
           let backgroundTextsView = (backgroundViewController as? AnimatedViewController)?.zoomingTextsView(for: self),
           let foregroundTextsView = (foregroundViewController as? AnimatedViewController)?.zoomingTextsView(for: self),
           let bottomTextView = (foregroundViewController as? AnimatedViewController)?.slidingTextView(for: self){
            
            let imageViewSnapshot = UIImageView(image: backgroundImageView.image)
            imageViewSnapshot.contentMode = .scaleAspectFill
            imageViewSnapshot.layer.masksToBounds = true
            imageViewSnapshot.layer.cornerRadius = 10
            
            var textsViewSnapshot : UIView
            textsViewSnapshot = backgroundTextsView.snapshotView(afterScreenUpdates: false) ?? UIView()
            textsViewSnapshot.frame = backgroundTextsView.frame
            
            if operation == .pop {
                textsViewSnapshot = foregroundTextsView.snapshotView(afterScreenUpdates: false) ?? UIView()
                textsViewSnapshot.frame = foregroundTextsView.frame
            }
            
            let screenSize = UIScreen.main.bounds.size
            
            var bottomTextSnapshot : UIView
            bottomTextSnapshot = bottomTextView.snapshotView(afterScreenUpdates: false) ?? UIView()
            bottomTextSnapshot.frame = CGRect(x: 0, y: 500, width: bottomTextView.frame.height, height: bottomTextView.frame.height)
            
            
            backgroundImageView.isHidden = true
            foregroundImageView.isHidden = true
            
            backgroundTextsView.isHidden = true
            foregroundTextsView.isHidden = true
            
            bottomTextView.isHidden = true
            
            let foregroundViewBackgroundColor = foregroundViewController.view.backgroundColor
            foregroundViewController.view.backgroundColor = UIColor.clear
            
            containerView.backgroundColor = UIColor.white
            containerView.addSubview(backgroundViewController.view)
            containerView.addSubview(foregroundViewController.view)
            containerView.addSubview(imageViewSnapshot)
            containerView.addSubview(textsViewSnapshot)
            containerView.addSubview(bottomTextSnapshot)
            
            var preTransitionState = TransitionState.initial
            var postTransitionState = TransitionState.final
            if operation == .pop {
                preTransitionState = .final
                postTransitionState = .initial
            }
            
            switch preTransitionState {
            case .initial:
                backgroundViewController.view.transform = CGAffineTransform.identity
                backgroundViewController.view.alpha = 1
                imageViewSnapshot.frame = containerView.convert(backgroundImageView.frame, from: backgroundImageView.superview)
                textsViewSnapshot.frame = containerView.convert(backgroundTextsView.frame, from: backgroundTextsView.superview)
//                bottomTextSnapshot.frame = containerView.convert(bottomTextView.frame, from: bottomTextView.superview)
                
            case .final:
                backgroundViewController.view.alpha = 0
                imageViewSnapshot.frame = containerView.convert(foregroundImageView.frame, from: foregroundImageView.superview)
                textsViewSnapshot.frame = containerView.convert(foregroundTextsView.frame, from: foregroundTextsView.superview)
                bottomTextSnapshot.frame = containerView.convert(bottomTextView.frame, from: bottomTextView.superview)
            }
            
            foregroundViewController.view.layoutIfNeeded()
            
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
                
                switch postTransitionState {
                case .initial:
                    backgroundViewController.view.transform = CGAffineTransform.identity
                    backgroundViewController.view.alpha = 1
                    imageViewSnapshot.frame = containerView.convert(backgroundImageView.frame, from: backgroundImageView.superview)
                    textsViewSnapshot.frame = containerView.convert(backgroundTextsView.frame, from: backgroundTextsView.superview)
                    bottomTextSnapshot.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 400)
                    
                case .final:
                    backgroundViewController.view.alpha = 0
                    imageViewSnapshot.frame = containerView.convert(foregroundImageView.frame, from: foregroundImageView.superview)
                    textsViewSnapshot.frame = containerView.convert(foregroundTextsView.frame, from: foregroundTextsView.superview)
                    
//                    bottomTextSnapshot.frame = containerView.convert(bottomTextView.frame, from: bottomTextView.superview)
                }

            }) { (finished) in
                
                backgroundViewController.view.transform = CGAffineTransform.identity
                imageViewSnapshot.removeFromSuperview()
                backgroundImageView.isHidden = false
                foregroundImageView.isHidden = false
                foregroundViewController.view.backgroundColor = foregroundViewBackgroundColor
                
                textsViewSnapshot.removeFromSuperview()
                backgroundTextsView.isHidden = false
                foregroundTextsView.isHidden = false
                
                bottomTextSnapshot.removeFromSuperview()
                bottomTextView.isHidden = false
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
 
        }
    }
    
}
