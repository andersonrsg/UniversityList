//
//  UniversityDetailViewController.swift
//  NovastoneCodeTest
//
//  Created by Anderson Gralha on 22/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import UIKit
import WebKit

class UniversityDetailViewController: UIViewController {
    
    // MARK: - Properties
    let webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    lazy var viewModel: UniversityDetailViewModel = {
        return UniversityDetailViewModel()
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(webView)
        viewModel.delegate = self
        webView.navigationDelegate = self
        loadUrl()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.webView.frame = view.bounds
    }
    
    // MARK: - Helpers
    func loadUrl() {
        self.webView.load(viewModel.url)
    }
}

// MARK: - WKNavigationDelegate
extension UniversityDetailViewController: WKNavigationDelegate {

}

// MARK: - UniversityDetailViewModelDelegate
extension UniversityDetailViewController: UniversityDetailViewModelDelegate {
    func didSetWebPage(url: String) {
        self.webView.load(url)
    }
}
