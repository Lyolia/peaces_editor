//
//  Coordinatorable.swift
//  face-app
//
//  Created by Aliona Kostenko on 10.07.2021.
//

import Foundation
import UIKit


protocol Coordinatorable: AnyObject {

    var rootViewController: UIViewController { get }
    var parentCoordinator: Coordinatorable? { get set }

    func start()
    func start(coordinator: Coordinatorable)
    func didFinish(coordinator: Coordinatorable)
    func removeChildCoordinators()
}
