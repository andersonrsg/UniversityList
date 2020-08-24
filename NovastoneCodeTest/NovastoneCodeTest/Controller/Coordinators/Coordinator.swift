//
//  Coordinator.swift
//  NovastoneCodeTest
//
//  Created by Anderson Gralha on 23/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import UIKit

public protocol Coordinator: class {
    init(navigationController: UINavigationController)
    func start()
}
