//
//  StickersCoordinator.swift
//  face-app
//
//  Created by Aliona Kostenko on 10.07.2021.
//

import UIKit
import Foundation


protocol TextMoveable: AnyObject {

    func navigationToSomeVC()
}


class TextCoordinator: NavigationCoordinator, TextMoveable {

    var textVC: TextViewController?

    func navigationToSomeVC() {

        //Change ThreeCoordinator to -> next coordinatorVC where you gonna move
//        let coordinator = ThreeCoordinator(navigationController: navigationController)
//        start(coordinator: coordinator)
    }

    override init(navigationController: UINavigationController = .init()) {

        super.init(navigationController: navigationController)
    }
 
    override func start() {

        let viewController = TextViewController(nibName: "TextViewController", bundle: nil)
        self.textVC = viewController
        viewController.modalPresentationStyle = .overFullScreen
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

extension TextCoordinator: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
    }
}


