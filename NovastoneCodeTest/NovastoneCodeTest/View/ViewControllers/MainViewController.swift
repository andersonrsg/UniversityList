//
//  MainViewController.swift
//  NovastoneCodeTest
//
//  Created by Anderson Gralha on 21/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import UIKit

class MainViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewController = UniversityListViewController(nibName: nil, bundle: nil)
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }

}
