//
//  WKWebViewExtension.swift
//  NovastoneCodeTest
//
//  Created by Anderson Gralha on 23/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import WebKit

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
