//
//  CustomNavigationControllerDelegate.swift
//  UIViewControllerAnimatedTransitioning-Demo
//
//  Created by Seb Vidal on 27/01/2023.
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning {
    private var operation: UINavigationController.Operation = .push
    private let duration: TimeInterval = 0.6
    
    private let startingPoint: CGPoint
    
    init(startingPoint: CGPoint) {
        self.startingPoint = startingPoint
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.operation = operation
        
        switch operation {
        case .push:
            return self
        default:
            return nil
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourceViewController = transitionContext.viewController(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        
        guard let destinationViewController = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        animateTransition(from: sourceViewController, to: destinationViewController, with: transitionContext)
    }
    
    private func animateTransition(from sourceViewController: UIViewController, to destinationViewController: UIViewController, with transitionContext: UIViewControllerContextTransitioning) {
        switch operation {
        case .push:
            guard let _ = sourceViewController as? MainViewController else {
                return
            }
            
            guard let destinationViewController = destinationViewController as? DetailViewController else {
                return
            }
            
            let containerView = transitionContext.containerView
            let destinationView = destinationViewController.view!
            destinationView.clipsToBounds = true
            destinationView.layer.cornerRadius = 15
            destinationView.layer.cornerCurve = .continuous
            
            let x = 16.0
            let y = startingPoint.y + 8
            let width = UIScreen.main.bounds.width - 32
            let height = width * 0.75
            destinationView.frame = CGRect(x: x, y: y, width: width, height: height)
            destinationView.layoutIfNeeded()
            
            containerView.addSubview(destinationView)
            
            let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.7) {
                let newWidth = UIScreen.main.bounds.width
                let newHeight = UIScreen.main.bounds.height
                destinationView.frame = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
                destinationView.layer.cornerRadius = 0
            }
            
            animator.addCompletion { position in
                transitionContext.completeTransition(position == .end)
            }
            
            animator.startAnimation()
        default:
            return
        }
    }
}
