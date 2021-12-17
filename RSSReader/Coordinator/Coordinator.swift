//
//  Coordinator.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 13.12.2021..
//

import Foundation
import UIKit

class Coordinator: NSObject {

    let rootNavigationController: UINavigationController

    var onEnd: (() -> Void)?

    private(set) var coordinators = [Coordinator]()

    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
        self.coordinators = []
    }

    func add(childCoordinator: Coordinator) {
        coordinators.append(childCoordinator)
    }

    func remove(childCoordinator: Coordinator) -> Coordinator? {
        if let index = coordinators.firstIndex(of: childCoordinator) {
            return coordinators.remove(at: index)
        } else {
            return nil
        }
    }

    func start() {}
}
