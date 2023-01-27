//
//  NavigationController.swift
//  UIViewControllerAnimatedTransitioning-Demo
//
//  Created by Seb Vidal on 27/01/2023.
//

import UIKit

class NavigationController: UINavigationController, UIGestureRecognizerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
}
