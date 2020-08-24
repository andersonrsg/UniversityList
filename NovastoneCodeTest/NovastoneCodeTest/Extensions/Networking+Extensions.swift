//
//  Networking+Extensions.swift
//  NovastoneCodeTest
//
//  Created by Anderson Gralha on 23/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import UIKit
import Alamofire

extension NetworkingController {
    struct TestRequest1: NetworkProtocol {
        var url: String = "https://www.google.com"
        var headers: HTTPHeaders? = nil
        var httpMethod: HTTPMethod = .get
        var parameters: Parameters? = nil
        var encoding: ParameterEncoding = URLEncoding.default
    }

    struct TestRequest2: NetworkProtocol {
        var url: String = ""
        var headers: HTTPHeaders? = nil
        var httpMethod: HTTPMethod = .get
        var parameters: Parameters? = nil
        var encoding: ParameterEncoding = URLEncoding.default
    }

}
