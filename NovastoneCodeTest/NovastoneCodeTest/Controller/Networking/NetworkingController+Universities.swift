//
//  NetworkingController+Universities.swift
//  NovastoneCodeTest
//
//  Created by Anderson Gralha on 21/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import Alamofire

extension NetworkingController {
    
    enum FetchUniversitiesResult {
        case success(universities: [University])
        case failure(FetchUniversitiesError)
        
        enum FetchUniversitiesError: Error {
            case unacceptableStatusCode
            case dataParsingFailed
            case error(Error)
        }
    }
    
    func fetchUniversities(completion: @escaping (FetchUniversitiesResult) -> Void) -> Void {
        let request = UniversitiesRequest()
        self.request(request) { (data, response, error) in
            // Check if Error took place
            if let error = error {
                completion(.failure(.error(error)))
            }

            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                guard NetworkingController.acceptableStatusCodes.contains(response.statusCode) else {
                    completion(.failure(.unacceptableStatusCode))
                    return
                }
            }

            // Convert HTTP Response Data to a simple String
            if let data = data {

                let universities = try? JSONDecoder().decode([University].self, from: data)
                if let universities = universities {
                    completion(.success(universities: universities))
                } else {
                    completion(.failure(.dataParsingFailed))
                }

            }
        }
    }
}

struct UniversitiesRequest: NetworkProtocol {
    var url: String = "https://raw.githubusercontent.com/Hipo/university-domains-list/master/world_universities_and_domains.json"
    var headers: HTTPHeaders? = nil
    var httpMethod: HTTPMethod = .get
    var parameters: Parameters? = nil
    var encoding: ParameterEncoding = URLEncoding.default
}
