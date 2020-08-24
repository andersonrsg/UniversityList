//
//  UniversityDetailCoordinator.swift
//  NovastoneCodeTest
//
//  Created by Anderson Gralha on 23/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import UIKit

class UniversityDetailCoordinator: Coordinator {
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController: UniversityListViewController = UniversityListViewController()
        viewController.delegate = self
        self.navigationController.viewControllers = [viewController]
    }
    
}

extension UniversityDetailCoordinator: UniversityListViewControllerDelegate {
    
    private func navigate(viewController: UIViewController) {
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToUniversityDetail(university: University) {
        guard let webPages = university.webPages else { return }
        
        // Create destination view controller
        let detailViewController = UniversityDetailViewController()
        detailViewController.title = university.name
        
        // Show action sheet only if we have more than 1 web page
        guard webPages.count > 1 else {
            if webPages.count > 0 {
                detailViewController.viewModel.setWebPage(url: webPages[0])
                navigate(viewController: detailViewController)
            }
            return
        }
        
        // Create action sheet to choose between web pages
        let sheet = UIAlertController(title: "Select University Page", message: nil, preferredStyle: .actionSheet)
        
        university.webPages?.forEach {
            let option = UIAlertAction(title: $0, style: .default) { [weak self] action in
                detailViewController.viewModel.setWebPage(url: action.title ?? "")
                self?.navigate(viewController: detailViewController)
            }
            sheet.addAction(option)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            sheet.dismiss(animated: true, completion: nil)
        }
        sheet.addAction(cancel)
        
        self.navigationController.topViewController?.present(sheet, animated: true, completion: nil)
    }
}
