//
//  NetworkingController.swift
//  NovastoneCodeTest
//
//  Created by Anderson Gralha on 20/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkProtocol {
    var url: String { get }
    var headers: HTTPHeaders? { get }
    var httpMethod: HTTPMethod { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
}

class NetworkingController {
    enum NetworkingResponse {
        case success(Data)
        case failure(NetworkingControllerError)
    }
    enum NetworkingControllerError: Error {
        case failedToBuildUrl
        case requestFailed(Error)
    }
    
    static var acceptableStatusCodes: Range<Int> { 200..<300 }
    static let shared = NetworkingController()
    
    func request(_ networkProtocol: NetworkProtocol, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        do {
            // Create Request
            let request = try buildRequest(networkProtocol)
            // Send HTTP Request
            // Could make use of Alamofire but since it's a simple request i'm only using it as a helper for my network protocol for now
            let task = URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
            task.resume()
        } catch {
            completionHandler(nil, nil, error)
        }
    }
    
    func buildRequest(_ networkProtocol: NetworkProtocol) throws -> URLRequest {
        guard let url = URL(string: networkProtocol.url) else {
            throw NetworkingControllerError.failedToBuildUrl
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = networkProtocol.httpMethod.rawValue
        request.allHTTPHeaderFields = networkProtocol.headers?.dictionary
        request.timeoutInterval = 180
        
        let parameters = networkProtocol.parameters ?? [:]
        let encoding = networkProtocol.encoding
        
        return try encoding.encode(request, with: parameters)
        
    }
}
